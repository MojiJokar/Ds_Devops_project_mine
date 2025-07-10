# DS_DevOps_project - Terraform Configuration

# AWS Provider Configuration
provider "aws" {
  region                   = var.aws_region
  shared_credentials_files = ["/mnt/c/Users/mmb20/.aws/credentials"]
  default_tags {
    tags = var.default_tags
  }
}

# Lookup the latest Amazon Linux 2 AMI in Paris (eu-west-3)
data "aws_ami" "latest_amazon_linux2_paris" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
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
  ami_id                    = data.aws_ami.latest_amazon_linux2_paris.id   
  instance_type             = "t2.medium"
  tag_name                  = "Jenkins:Ubuntu Linux EC2"
  public_key                = var.public_key
  subnet_id                 = tolist(module.networking.public_subnet)[0]
  sg_for_jenkins            = [module.security_group.sg_ec2_sg_ssh_http_id, module.security_group.sg_ec2_jenkins_port_8080]
  enable_public_ip_address  = true
  user_data_install_jenkins = templatefile("./modules/jenkins-runner-script/jenkins-installer.sh", {})
}

module "lb_target_group" {
  source                   = "./modules/load-balancer-target-group"
  lb_target_group_name     = "jenkins-lb-target-group"
  lb_target_group_port     = 8080
  lb_target_group_protocol = "HTTP"
  vpc_id                   = module.networking.vpc_id
  ec2_instance_id          = module.jenkins.jenkins_ec2_instance_ip
}

module "alb" {
  source                    = "./modules/load-balancer"
  lb_name                   = "ds-devops-project-alb"
  is_external               = false
  lb_type                   = "application"
  sg_enable_ssh_https       = module.security_group.sg_ec2_sg_ssh_http_id
  subnet_ids                = tolist(module.networking.public_subnet)
  tag_name                  = "ds_devops_project-alb"
  lb_target_group_arn       = module.lb_target_group.ds_devops_project_lb_target_group_arn
  ec2_instance_id           = module.jenkins.jenkins_ec2_instance_ip
  lb_listner_port           = 80
  lb_listner_protocol       = "HTTP"
  lb_listner_default_action = "forward"
  lb_https_listner_port     = 443
  lb_https_listner_protocol = "HTTPS"
  # ds_devops_project_acm_arn        = module.aws_ceritification_manager.ds_devops_project_acm_arn
  lb_target_group_attachment_port = 8080
}

/*
module "hosted_zone" {
  source          = "./modules/hosted-zone"
  domain_name     = "jenkins.jhooq.org"
  aws_lb_dns_name = module.alb.aws_lb_dns_name
  aws_lb_zone_id  = module.alb.aws_lb_zone_id
}

module "aws_ceritification_manager" {
  source         = "./modules/certificate-manager"
  domain_name    = "jenkins.jhooq.org"
  hosted_zone_id = module.hosted_zone.hosted_zone_id
}
*/

# RDS Module - Creates PostgreSQL database
module "rds" {
  source = "./modules/rds"

  environment           = var.environment
  subnet_ids            = module.networking.private_subnet_ids
  vpc_security_group_ids = [module.networking.db_security_group_id]
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
  db_instance_class     = var.db_instance_class
  skip_final_snapshot   = var.skip_final_snapshot
}

/*
module "eks" {
    source  = "./modules/terraform-aws-modules/eks/aws"
    version = "~> 19.0"
    cluster_name = "myapp-eks-cluster"
    cluster_version = "1.24"

    cluster_endpoint_public_access  = true

    vpc_id = module.myapp-vpc.vpc_id
    subnet_ids = module.myapp-vpc.private_subnets

    tags = {
        environment = "development"
        application = "myapp"
    }

    eks_managed_node_groups = {
        dev = {
            min_size = 1
            max_size = 3
            desired_size = 2

            instance_types = ["t2.small"]
        }
    }
}
*/
