variable "db_name" {
  type = string

}
variable "engine_type" {
  type = string
}
variable "engine_version" {
  type = string
}
variable "db_instance_type" {
  type = string
}
variable "db_user" {
  type = string
}
variable "db_passwd" {
  type = string
}
variable "rds_sg" {
  type = list(string)
 
}
variable "private_subnet_ids" {
  description = "List of private subnet IDs for the RDS subnet group (2 AZs recommended)"
  type        = list(string)
}
variable "allocated_storage" {
  type = number
}

variable "deletion_protection" {
  type    = bool
  default = false
}
