# WordPress on AWS Terraform Multi-AZ Infrastructure

This project demonstrates the deployment of a **highly available WordPress application** on AWS using **Terraform** and modular Infrastructure as Code practices. It includes networking, compute, database, load balancing, and secure state management, a complete end to end cloud environment.

<img width="670" height="586" alt="alb_frontend" src="https://github.com/user-attachments/assets/1eed0e4f-06dd-417c-875a-499f299bdff0" />


## 📂 File Structure

```
DevOps-Learning-Terraform/
│
├── envs/
│   └── dev/
│       ├── main.tf
│       ├── variables.tf
│       ├── terraform.tfvars
│       ├── outputs.tf
│       └── providers.tf
│
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── ec2_wordpress/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── wordpress.tpl   # cloud-init template
│   │
│   ├── rds_mysql/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── alb/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
└── README.md
```

---

## Goals

* Deploy a **multi-AZ WordPress environment** with Terraform  
* Use **modular design** (VPC, EC2, RDS, ALB separated)  
* Secure infrastructure with **least privilege security groups**  
* Automate WordPress installation via `cloud-init`  
* Manage Terraform state with **S3 backend**  

---

## Tech Stack

* **Terraform** - Infrastructure as Code  
* **AWS** - VPC, EC2, RDS, ALB, S3,   
* **WordPress** - Application layer  
* **MySQL RDS** - Database backend  
* **Cloud-Init** - EC2 bootstrapping  

---

### Prerequisites
- AWS account with permissions (VPC, EC2, RDS, ALB, S3)  
- Terraform installed  
- AWS CLI configured (`aws configure`)  
- Existing **S3 bucket** with versioning and state locking enabled (update `backend.tf` accordingly)  

### Deployment Steps

```bash
# 1. Clone repository
git clone https://github.com/yassinsuleiman/DevOps-Learning-Terraform.git
cd DevOps-Learning-Terraform/envs/dev

# 2. Copy and edit variables
mv terraform.tfvars.example terraform.tfvars

# Update values:
	•	VPC + Subnets - CIDR blocks for VPC, public, and private subnets
	•	SSH Access - my_ip_cidr (your public IP/32) + key_name (your EC2 keypair)
	•	EC2 (WordPress app) - ami_type, instance_type, optional acm_cert_arn
	•	RDS Database - db_user, db_passwd, db_name

# 3. Initialize with remote backend or locally
terraform init

# 4. Preview resources
terraform plan

# 5. Apply changes
terraform apply

# 6. Access WordPress
# Once complete, Terraform will output the ALB DNS endpoint.
# Open it in your browser to access WordPress setup.

# 7. Cleanup (destroy resources when done)
terraform destroy
```

---

## Key Features

### Networking
* VPC with 2 public + 2 private subnets across AZs  
* Internet Gateway + route tables for connectivity  

### Compute
* EC2 instances provisioned with WordPress (cloud-init)  
* Deployed in multiple AZs for redundancy  

### Database
* MySQL RDS with Multi-AZ enabled  
* Hosted in private subnets  

### Load Balancing
* Application Load Balancer distributing traffic  
* Health checks to maintain availability  

### Security
* ALB SG: open HTTP/HTTPS  
* EC2 SG: only ALB + SSH from my IP  
* RDS SG: only EC2 SG access on 3306  

### State Management
* S3 bucket for Terraform state  


---

## Problems I Encountered

### 1. Variables & Outputs Pipeline
The biggest struggle was wiring variables and outputs across modules.  
I often thought I had defined everything, yet Terraform still prompted me.  
This forced me to really understand how values flow:  
**`variables.tf → tfvars → module inputs → outputs.tf`**

### 2. Modularization
Running resources flat was easy, modularizing was not.  
Breaking VPC, EC2, RDS, and ALB into modules exposed gaps in my understanding of input/output design and module boundaries.  
I learned that **clean modules are about minimal, precise outputs, not duplicating everything.**

### 3. Bootstrapping WordPress (Cloud-init)
Cloud-init was another major hurdle.  
At first, WordPress deployed but the config stayed blank, so DB connections failed.  
It took trial and error to get the syntax right and ensure `wp-config.php` was injected with the correct DB host, user, and password.

---

## Lessons Learned

* Importance of **modular Terraform design** for clarity and reusability  
* How to manage **remote state** with S3 + State locking
* Applying **least privilege** in security group rules  
* Debugging health checks, DB connectivity, and bootstrap automation  
* Using **cloud-init** to preconfigure WordPress, ensuring instances are production-ready on launch  

---

## Why It’s Valuable

This project represents a **production-style deployment** of a classic application. It highlights skills in:

* Cloud infrastructure design (VPC, ALB, RDS, EC2)  
* Terraform automation and modularization  
* Secure networking with layered security groups  
* High availability across multiple availability zones  
* State management for collaborative IaC workflows  

---

👤 **Author:** Yassin Suleiman  
📍 Switzerland | DevOps Engineer
