# VPC
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public1_subnet_cidr" {
  description = "CIDR for the first public subnet (AZ-a)"
  type        = string
}

variable "public2_subnet_cidr" {
  description = "CIDR for the second public subnet (AZ-b)"
  type        = string
}

variable "private1_subnet_cidr" {
  description = "CIDR for the first private subnet (AZ-a)"
  type        = string
}

variable "private2_subnet_cidr" {
  description = "CIDR for the second private subnet (AZ-b)"
  type        = string
}

# Security
variable "my_ip_cidr" {
  description = "Your public IP in CIDR (/32) for SSH access"
  type        = string
}

# EC2
variable "ami_type" {
  description = "AMI ID for EC2"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2"
  type        = string
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}

variable "ec2_sg_id" {
  description = "List of EC2 security group IDs"
  type        = list(string)
}

variable "acm_cert_arn" {
  description = "ARN of the ACM certificate for HTTPS"
  type        = string
}
# RDS
variable "engine_type" {
  description = "Database engine"
  type        = string
}

variable "engine_version" {
  description = "Database engine version"
  type        = string
}

variable "db_instance_type" {
  description = "RDS instance type"
  type        = string
}

variable "allocated_storage" {
  description = "RDS allocated storage in GB"
  type        = number
}

variable "db_name" {
  description = "RDS database name"
  type        = string
}

variable "db_user" {
  description = "RDS username"
  type        = string
}

variable "db_passwd" {
  description = "RDS password"
  type        = string
  sensitive   = true
}

variable "deletion_protection" {
  description = "Whether to enable deletion protection on RDS"
  type        = bool
  default     = false
}
