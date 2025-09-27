# Security Group for Wordpress Instance
resource "aws_security_group" "wp_sg" {
  name        = "wp_sg"
  description = "Allow HTTP from everywhere and SSH from Host address"
  vpc_id      = aws_vpc.wp.id

  tags = {
    Name = "Wordpress"
  }
}

# Security Group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Allow SQL from wp_sg"
  vpc_id      = aws_vpc.wp.id

  tags = {
    Name = "Wordpress"
  }
}

# Allow inbound HTTP from everywhere
resource "aws_vpc_security_group_ingress_rule" "allow_http_all" {
  security_group_id = aws_security_group.wp_sg.id  
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}
# Allow inbound SSH from designated Host_Address (Variable)
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_host" {
  security_group_id = aws_security_group.wp_sg.id  
  cidr_ipv4         = var.my_ip_cidr
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# Allow inbound SQL from WordPress Instance to RDS
resource "aws_vpc_security_group_ingress_rule" "allow_sql" {
  security_group_id = aws_security_group.rds_sg.id
  referenced_security_group_id = aws_security_group.wp_sg.id
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}
