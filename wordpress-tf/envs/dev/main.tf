# Create VPC
module "vpc" {
  source               = "../../modules/vpc"
  vpc_cidr             = var.vpc_cidr
  public1_subnet_cidr  = var.public1_subnet_cidr
  public2_subnet_cidr  = var.public2_subnet_cidr
  private1_subnet_cidr = var.private1_subnet_cidr
  private2_subnet_cidr = var.private2_subnet_cidr
  my_ip_cidr           = var.my_ip_cidr
}
# Create RDS MySQL
module "rds" {
  source               = "../../modules/rds_mysql"

  engine_type          = var.engine_type
  engine_version       = var.engine_version
  db_instance_type     = var.db_instance_type
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  db_user              = var.db_user
  db_passwd            = var.db_passwd

  # pass SG as a single ID
  rds_sg               = [module.vpc.rds_sg_id]

  private_subnet_ids = [
    module.vpc.private_subnet_id_1,
    module.vpc.private_subnet_id_2
  ]
  deletion_protection  = var.deletion_protection
}

# Create EC2 instances (WordPress)
module "ec2" {
  source        = "../../modules/ec2_wordpress"

  ami_type      = var.ami_type
  instance_type = var.instance_type
  key_name      = var.key_name

  public_subnet_ids = [
    module.vpc.public_subnet_id_1,
    module.vpc.public_subnet_id_2
  ]

  # pass SG as a single ID
  ec2_sg_id = [module.vpc.wp_sg_id]

  db_host   = module.rds.rds_endpoint
  db_name   = var.db_name
  db_user   = var.db_user
  db_passwd = var.db_passwd
}
# Create ALBs
module "alb" {
  source          = "../../modules/alb"

  vpc_id          = module.vpc.vpc_id
  public_subnet_1 = module.vpc.public_subnet_id_1
  public_subnet_2 = module.vpc.public_subnet_id_2

  # pass SG as a single ID
  alb_sg_id       = module.vpc.alb_sg_id

  app1_id         = module.ec2.ec2_instance_id1
  app2_id         = module.ec2.ec2_instance_id_app2

  http              = 80
  https             = 443
  acm_cert_arn      = var.acm_cert_arn
  health_check_path = "/"
}