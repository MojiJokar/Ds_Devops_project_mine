# DS_DevOps_project - Terraform Variables

# AWS Region
aws_region = "eu-west-3"

# Environment
environment = "dev"

# Default Tags
default_tags = {
  Project     = "DS_DevOps_project"
  Environment = "dev"
  ManagedBy   = "Terraform"
}

# VPC and Networking
vpc_cidr             = "10.0.0.0/16"
// vpc_name             =  "main"
availability_zones   = ["eu-west-3a", "eu-west-3b"]
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]

# Database
db_name           = "dsdevops"
db_username       = "dbadmin"
db_password       = "DS_DevOps_Secure_Pwd_2025!" 
db_instance_class = "db.t3.micro"

# ECS
frontend_container_port = 80
backend_container_port  = 8080
frontend_cpu            = 256
frontend_memory         = 512
backend_cpu             = 512
backend_memory          = 1024

#domain_name = "http://localhost:3000/ "
#ec2_ami_id     = "ami-06dd92ecc74fdfb36"
public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDejszGdE68iK34ITFS2yE0xQj/q2rvg6Hq0tz8pkqwp9fWrIGGKiaOelF2EUCm6YC4TgLK3XgpS9q00qHDFPNg//whY2n45jQPonZplpggiPzA/oa9slMxqynL1hxgUSQ/P9eVNP3pPLOyHrCUA1LcS4bBzdX3AL2xujwWveRf11GC/Q4zcf9dqZLG8FjjHJtQUoXj2P5vkd2LotuOkIDDjMC3kYuyD5YG70R5hRNxCWSD9aoYLejz7WYtfbdjyLL0Lr3FlvyIjsLUzh+aNY78m8xzcTU9IvBY5W31sNMmGUcQmIYl6PRx3qTUBuCGD14z7zzgyxo/jLvlhZQjuqf7uDoroug20dHhV4wD+TlfOXB0nzlHrdemPqcJtR7DBO9nFLk//0yhqHCcKh7rbu2GTh"


