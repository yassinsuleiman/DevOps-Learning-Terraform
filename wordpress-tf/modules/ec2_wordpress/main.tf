# App1 in public_subnet_ids[0]
resource "aws_instance" "app1" {
  ami                         = var.ami_type
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_ids[0]
  vpc_security_group_ids      = var.ec2_sg_id
  associate_public_ip_address = true
  key_name                    = var.key_name

  user_data = templatefile("${path.module}/wordpress.tpl", {
    db_host   = var.db_host
    db_name   = var.db_name
    db_user   = var.db_user
    db_passwd = var.db_passwd
  })

  tags = { Name = "WordPress-App1" }
}

# EIP for App1
resource "aws_eip" "app1" {
  domain = "vpc"
  tags   = { Name = "wp-app1-eip" }
}

resource "aws_eip_association" "app1_assoc" {
  instance_id   = aws_instance.app1.id
  allocation_id = aws_eip.app1.id
}

# App2 in public_subnet_ids[1]
resource "aws_instance" "app2" {
  ami                         = var.ami_type
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_ids[1]
  vpc_security_group_ids      = var.ec2_sg_id
  associate_public_ip_address = true
  key_name                    = var.key_name

  user_data = templatefile("${path.module}/wordpress.tpl", {
    db_host   = var.db_host
    db_name   = var.db_name
    db_user   = var.db_user
    db_passwd = var.db_passwd
  })

  tags = { Name = "WordPress-App2" }
}

# EIP for App2
resource "aws_eip" "app2" {
  domain = "vpc"
  tags   = { Name = "wp-app2-eip" }
}

resource "aws_eip_association" "app2_assoc" {
  instance_id   = aws_instance.app2.id
  allocation_id = aws_eip.app2.id
}