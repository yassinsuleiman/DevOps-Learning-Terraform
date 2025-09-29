# Create the RDS instance
resource "aws_db_instance" "rds" {
  engine                 = var.engine_type
  engine_version         = var.engine_version
  instance_class         = var.db_instance_type
  allocated_storage      = var.allocated_storage
  db_name                = var.db_name
  username               = var.db_user
  password               = var.db_passwd

  db_subnet_group_name   = aws_db_subnet_group.rds_db.name
  vpc_security_group_ids = var.rds_sg

  publicly_accessible    = false
  skip_final_snapshot    = true

  # High availability and safety
  multi_az               = true
  deletion_protection    = var.deletion_protection

  tags = {
    Name = "rds"
  }
}

# Create a DB subnet group for RDS in the private subnets

resource "aws_db_subnet_group" "rds_db" {
  name       = "rds-subnets"
  subnet_ids = var.private_subnet_ids  

  tags = { Name = "rds-subnets" }
}
