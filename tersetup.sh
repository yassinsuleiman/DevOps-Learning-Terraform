#!/bin/bash

# Root files
mkdir -p wordpress-tf/{modules/{vpc,rds_mysql,ec2_wordpress},envs/dev,diagrams}
cd wordpress-tf

# Root-level files
touch README.md .gitignore Makefile

# Diagram placeholder
touch diagrams/architecture.png

# VPC module
touch modules/vpc/{main.tf,subnets.tf,security_groups.tf,variables.tf,outputs.tf}

# RDS module
touch modules/rds_mysql/{main.tf,variables.tf,outputs.tf}

# EC2 module
touch modules/ec2_wordpress/{main.tf,variables.tf,outputs.tf,wordpress.tpl}

# Env dev files
touch envs/dev/{versions.tf,providers.tf,backend.tf,variables.tf,main.tf,outputs.tf,terraform.tfvars.example}

echo "✅ Terraform assignment structure created successfully."