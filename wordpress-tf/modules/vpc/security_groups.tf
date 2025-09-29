# ALB SG
resource "aws_security_group" "alb_sg" {
  name        = "wp-alb-sg"
  description = "ALB ingress 80/443"
  vpc_id      = aws_vpc.wp.id

  tags = { Name = "wp-alb-sg" }
}

# allow 80/443 from everywhere to ALB
resource "aws_vpc_security_group_ingress_rule" "alb_http_in" {
  security_group_id = aws_security_group.alb_sg.id
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_ipv4         = "0.0.0.0/0"
}
resource "aws_vpc_security_group_ingress_rule" "alb_https_in" {
  security_group_id = aws_security_group.alb_sg.id
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_ipv4         = "0.0.0.0/0"
}
resource "aws_vpc_security_group_egress_rule" "alb_all_out" {
  security_group_id = aws_security_group.alb_sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

# WordPress EC2 SG
resource "aws_security_group" "wp_sg" {
  name        = "wp_sg"
  description = "WordPress EC2 SG (HTTP/HTTPS from ALB, SSH from my IP)"
  vpc_id      = aws_vpc.wp.id

  tags = { Name = "wp_sg" }
}

# allow HTTP/HTTPS from ALB sg only
resource "aws_vpc_security_group_ingress_rule" "wp_http_from_alb" {
  security_group_id            = aws_security_group.wp_sg.id
  ip_protocol                  = "tcp"
  from_port                    = 80
  to_port                      = 80
  referenced_security_group_id = aws_security_group.alb_sg.id
}
resource "aws_vpc_security_group_ingress_rule" "wp_https_from_alb" {
  security_group_id            = aws_security_group.wp_sg.id
  ip_protocol                  = "tcp"
  from_port                    = 443
  to_port                      = 443
  referenced_security_group_id = aws_security_group.alb_sg.id
}

# allow SSH from YOUR IP (comes from var.my_ip_cidr)
resource "aws_vpc_security_group_ingress_rule" "wp_ssh_from_me" {
  security_group_id = aws_security_group.wp_sg.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = var.my_ip_cidr
}

# egress all for EC2
resource "aws_vpc_security_group_egress_rule" "wp_all_outbound" {
  security_group_id = aws_security_group.wp_sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

# RDS SG (only MySQL from EC2 SG)
resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "MySQL from WordPress EC2 SG only"
  vpc_id      = aws_vpc.wp.id

  tags = { Name = "rds_sg" }
}

resource "aws_vpc_security_group_ingress_rule" "rds_mysql_in" {
  security_group_id            = aws_security_group.rds_sg.id
  ip_protocol                  = "tcp"
  from_port                    = 3306
  to_port                      = 3306
  referenced_security_group_id = aws_security_group.wp_sg.id
}

resource "aws_vpc_security_group_egress_rule" "rds_all_outbound" {
  security_group_id = aws_security_group.rds_sg.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

