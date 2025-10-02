# Variables for ALB module
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_1" {
  description = "Public subnet ID (AZ1)"
  type        = string
}

variable "public_subnet_2" {
  description = "Public subnet ID (AZ2)"
  type        = string
}

variable "alb_sg_id" {
  description = "ALB security group ID"
  type        = string
}

variable "app1_id" {
  description = "EC2 instance ID for app1"
  type        = string
}

variable "app2_id" {
  description = "EC2 instance ID for app2"
  type        = string
}

variable "http" {
  description = "HTTP port"
  type        = number
  default     = 80
}

variable "https" {
  description = "HTTPS port"
  type        = number
  default     = 443
}

variable "acm_cert_arn" {
  description = "ACM certificate ARN (leave empty to skip HTTPS)"
  type        = string
  default     = ""
}

variable "health_check_path" {
  description = "Health check path"
  type        = string
  default     = "/"
}