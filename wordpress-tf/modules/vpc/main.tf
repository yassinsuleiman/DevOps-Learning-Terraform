# Create VPC
resource "aws_vpc" "wp" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

# Create internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.wp.id

  tags = {
    Name = "main_gw"
  }
}




