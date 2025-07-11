# DS_DevOps_project - Terraform Variables

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-west-3" # Paris region as specified in requirements
}

/*variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}*/

variable "default_tags" {
  description = "Default tags to apply to all resources"
  type        = map(string)
  default = {
    Project     = "DS_DevOps_project"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}

# VPC and Networking Variables
/*variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones to use"
  type        = list(string)
  default     = ["eu-west-3a", "eu-west-3b"] # Using two AZs in Paris region
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

# Database Variables
variable "db_name" {
  description = "Name of the database"
  type        = string
  default     = "dsdevops"
}

variable "db_username" {
  description = "Username for the database"
  type        = string
  default     = "dbadmin"
  sensitive   = true
}

variable "db_password" {
  description = "Password for the database"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "Instance class for the RDS instance"
  type        = string
  default     = "db.t3.micro" # As specified in requirements
}

# ECS Variables
variable "frontend_container_port" {
  description = "Port the frontend container listens on"
  type        = number
  default     = 80
}

variable "backend_container_port" {
  description = "Port the backend container listens on"
  type        = number
  default     = 8080
}

variable "frontend_cpu" {
  description = "CPU units for the frontend container"
  type        = number
  default     = 256
}

variable "frontend_memory" {
  description = "Memory for the frontend container in MiB"
  type        = number
  default     = 512
}

variable "backend_cpu" {
  description = "CPU units for the backend container"
  type        = number
  default     = 512
}

variable "backend_memory" {
  description = "Memory for the backend container in MiB"
  type        = number
  default     = 1024
}
# variable "ec2_ami_id" {
#   type        = string
#   description = "DevOps Project 1 AMI Id for EC2 instance"
# }

# variable "eu_availability_zone" {
#   type        = list(string)
#   description = "Availability Zones"
# }

variable "public_key" {
   type        = string
   description = "DevOps Project 1 Public key for EC2 instance"
}

# variable "vpc_name" {
#   type        = string
#   description = "DevOps Project 1 VPC 1"
# }

# variable "bucket_name" {
#   type        = string
#   description = "Remote state bucket name"
# }

# variable "name" {
#   type        = string
#   description = "Tag name"
# }

variable "ec2_ami_id" {
  type        = string
  description = "DevOps Project 1 AMI Id for EC2 instance"
}
variable "skip_final_snapshot" {
  type        = bool
  description = "Whether to skip the final DB snapshot before deletion"
  default     = false
}*/

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "private_subnets" {
  description = "Subnets CIDR"
  type        = list(string)
}

variable "public_subnets" {
  description = "Subnets CIDR"
  type        = list(string)
}

variable "instance_type" {
  description = "Instance Type"
  type        = string
}

