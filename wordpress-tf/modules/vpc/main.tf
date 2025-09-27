resource "aws_vpc" "wp" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.wp.id

  tags = {
    Name = "main_gw"
  }
}

#harness
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

}

# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
}



