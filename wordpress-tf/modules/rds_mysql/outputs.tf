output "rds_endpoint" {
  description = "DNS of the RDS Database"
  value = aws_db_instance.rds.endpoint
}