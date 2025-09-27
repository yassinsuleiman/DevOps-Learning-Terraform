output "vpc_id" {
  value = aws_vpc.wp.id
}

output "public_subnet_id" {
  value = aws_subnet.public_1.id
}

output "private_subnet_id" {
  value = aws_subnet.private_1.id
}

output "wp_sg_id" {
  value = aws_security_group.wp_sg.id
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}