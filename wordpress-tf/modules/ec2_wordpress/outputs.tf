output "ec2_instance_id1" {
  description = "App1 ID"
  value       = aws_instance.app1.id
}

output "ec2_instance_id_app2" {
  description = "App2 ID"
  value       = aws_instance.app2.id
}

output "ec2_public_dns1" {
  description = "App1 Public DNS"
  value       = aws_instance.app1.public_dns
}

output "ec2_public_dns_app2" {
  description = "App2 Public DNS"
  value       = aws_instance.app2.public_dns
}

output "ec2_eip1" {
  description = "App1 EIP"
  value       = aws_eip.app1.public_ip
}

output "ec2_eip_app2" {
  description = "App2 EIP"
  value       = aws_eip.app2.public_ip
}