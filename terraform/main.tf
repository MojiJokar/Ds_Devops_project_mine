# DS_DevOps_project - Terraform Configuration

# AWS Provider Configuration
provider "aws" {
  region = var.aws_region
  shared_credentials_files = ["/mnt/c/Users/mmb20/.aws/credentials"]
  default_tags {
    tags = var.default_tags
  }
}

# Terraform Backend Configuration (Uncomment and configure when ready for production)
# terraform {
#   backend "s3" {
#     bucket         = "ds-devops-project-terraform-state"
#     key            = "terraform.tfstate"
#     region         = "eu-west-3"
#     dynamodb_table = "ds-devops-terraform-locks"
#     encrypt        = true
#   }
# }

# Networking Module - Creates VPC, Subnets, Internet Gateway, NAT Gateway, Route Tables
module "networking" {
  source = "./modules/networking"
  
  vpc_cidr             = var.vpc_cidr
  environment          = var.environment
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "security_group" {
  source              = "./modules/security-groups"
  ec2_sg_name         = "SG for EC2 to enable SSH(22), HTTPS(443) and HTTP(80)"
  vpc_id              = module.networking.vpc_id
  ec2_jenkins_sg_name = "Allow port 8080 for jenkins"
}

module "jenkins" {
  source                    = "./modules/jenkins"
  ami_id                    = var.ec2_ami_id
  instance_type             = "t2.medium" 
  tag_name                  = "Jenkins:Ubuntu Linux EC2"
  public_key                = var.public_key
  subnet_id                 = tolist(module.networking.public_subnet)[0]
  sg_for_jenkins            = [module.security_group.sg_ec2_sg_ssh_http_id, module.security_group.sg_ec2_jenkins_port_8080]
  enable_public_ip_address  = true
  user_data_install_jenkins = templatefile("./modules/jenkins-runner-script/jenkins-installer.sh", {})
}
