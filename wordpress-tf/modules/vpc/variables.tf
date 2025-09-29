variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
  
}

variable "public1_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}
variable "public2_subnet_cidr" {
  description = "The CIDR block for the second public subnet"
  type        = string
}

variable "private1_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}
variable "private2_subnet_cidr" {
  description = "The CIDR block for the second private subnet"
  type        = string
}

variable "my_ip_cidr" {
description = "Host IP in CIDR for the Ingress SSH Rule in SG"
type = string
validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/32$", var.my_ip_cidr))
    error_message = "Must be a valid IPv4 address with /32, e.g., 203.0.113.45/32."
  }
}
