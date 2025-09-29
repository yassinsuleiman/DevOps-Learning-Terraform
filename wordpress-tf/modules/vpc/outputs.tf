output "vpc_id" {
  value = aws_vpc.wp.id
}

output "public_subnet_id_1" {
  value = aws_subnet.public_1.id
}

output "public_subnet_id_2" {
  value = aws_subnet.public_2.id
}

output "private_subnet_id_1" {
  value = aws_subnet.private_1.id
}

output "private_subnet_id_2" {
  value = aws_subnet.private_2.id
}

output "wp_sg_id" {
  value = aws_security_group.wp_sg.id
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}