# VPC Module
module "vpc" {
  source = "./modules/vpc"

  project_name          = var.project_name
  environment           = var.environment
  vpc_cidr              = var.vpc_cidr
  availability_zones    = var.availability_zones
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  secure_subnet_cidrs   = var.secure_subnet_cidrs
}

# Security Groups Module
module "security_groups" {
  source = "./modules/security-groups"

  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.vpc.vpc_id
}

# RDS Module
module "rds" {
  source = "./modules/rds"

  project_name          = var.project_name
  environment           = var.environment
  vpc_id                = module.vpc.vpc_id
  secure_subnet_ids     = module.vpc.secure_subnet_ids
  rds_security_group_id = module.security_groups.rds_security_group_id
  database_name         = var.database_name
  database_username     = var.database_username
  database_password     = var.database_password
}

# ALB Module
module "alb" {
  source = "./modules/alb"

  project_name           = var.project_name
  environment            = var.environment
  vpc_id                 = module.vpc.vpc_id
  public_subnet_ids      = module.vpc.public_subnet_ids
  alb_security_group_id  = module.security_groups.alb_security_group_id
  vpc_cidr               = module.vpc.vpc_cidr
}

# Auto Scaling Group Module
module "asg" {
  source = "./modules/asg"

  project_name           = var.project_name
  environment            = var.environment
  vpc_id                 = module.vpc.vpc_id
  private_subnet_ids     = module.vpc.private_subnet_ids
  ec2_security_group_id  = module.security_groups.ec2_security_group_id
  target_group_arn       = module.alb.target_group_arn
  instance_type          = var.instance_type
  min_size               = var.asg_min_size
  max_size               = var.asg_max_size
  desired_capacity       = var.asg_desired_capacity
}
