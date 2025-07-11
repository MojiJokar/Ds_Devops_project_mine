/*variable "cluster_name" {}
variable "cluster_version" {}
variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "tags" {
  type = map(string)
}
variable "eks_managed_node_groups" {
  type = any
}
variable "cluster_endpoint_public_access" {
  type    = bool
  default = true
}

output "cluster_id" {
  value = module.eks.cluster_id
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  value = module.eks.cluster_security_group_id
}

output "kubeconfig" {
  value = module.eks.kubeconfig
}

output "node_group_role_arn" {
  value = module.eks.node_group_role_arn
}*/

provider "aws" {
  region                   = var.aws_region
  shared_credentials_files = ["/mnt/c/Users/mmb20/.aws/credentials"]
  default_tags {
    tags = var.default_tags
  }
}

/*module "networking" {
  source = "../modules/networking"

  vpc_cidr             = var.vpc_cidr
  environment          = var.environment
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}*/


/*module "security_group" {
  source              = "../modules/security-groups"
  ec2_sg_name         = "SG for EC2 to enable SSH(22), HTTPS(443) and HTTP(80)"
  vpc_id              = module.networking.vpc_id
  ec2_jenkins_sg_name = "Allow port 8080 for jenkins"
}

module "jenkins" {
  source                    = "../modules/jenkins"
  ami_id                    = var.ec2_ami_id 
  instance_type             = "t2.medium"
  tag_name                  = "Jenkins:Ubuntu Linux EC2"
  public_key                = var.public_key
  subnet_id                 = tolist(module.networking.public_subnet)[0]
  sg_for_jenkins            = [module.security_group.sg_ec2_sg_ssh_http_id, module.security_group.sg_ec2_jenkins_port_8080]
  enable_public_ip_address  = true
  user_data_install_jenkins = file("../modules/jenkins-runner-script/jenkins-install.sh")

}*/
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jenkins-vpc"
  cidr = var.vpc_cidr

  azs = data.aws_availability_zones.azs.names

  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_dns_hostnames = true
  enable_nat_gateway   = true
  single_nat_gateway   = true

  tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/elb"               = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"      = 1
  }

}

module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name    = "my-eks-cluster"
  cluster_version = "1.24"

  cluster_endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    nodes = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_types = ["t2.small"]
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
