# Variables for EC2 WordPress module
variable "ami_type" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs across 2 AZs"
  type        = list(string)
}

variable "ec2_sg_id" {
  description = "Security group IDs for EC2 instances"
  type        = list(string)
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "db_host" {
  description = "Database endpoint for WordPress"
  type        = string
}

variable "db_name" {
  description = "Database name for WordPress"
  type        = string
}

variable "db_user" {
  description = "Database user for WordPress"
  type        = string
}

variable "db_passwd" {
  description = "Database password for WordPress"
  type        = string
  sensitive   = true
}