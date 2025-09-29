output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id_1" {
  value = module.vpc.public_subnet_id_1
}

output "public_subnet_id_2" {
  value = module.vpc.public_subnet_id_2
}

output "private_subnet_id_1" {
  value = module.vpc.private_subnet_id_1
}

output "private_subnet_id_2" {
  value = module.vpc.private_subnet_id_2
}

output "ec2_app1_public_ip" {
  value = module.ec2.ec2_eip1
}

output "ec2_app2_public_ip" {
  value = module.ec2.ec2_eip_app2
}

output "ec2_app1_dns" {
  value = module.ec2.ec2_public_dns1
}

output "ec2_app2_dns" {
  value = module.ec2.ec2_public_dns_app2
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "alb_dns" {
  value = module.alb.alb_dns
}