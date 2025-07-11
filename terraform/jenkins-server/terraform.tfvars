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
/*vpc_cidr             = "10.0.0.0/16"
// vpc_name             =  "main"
availability_zones   = ["eu-west-3a", "eu-west-3b"]
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
*/

vpc_cidr              = "10.0.0.0/16"
public_subnet_cidrs   = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnet_cidrs  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
availability_zones    = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]






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
ec2_ami_id = "ami-007c433663055a1cc"

public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDE6jT41I6TzwN2U5tl/21n+4CpvGn7nXLhvf8iyz4sf1Th0ot+bxdzbXgB15MGWgASmMUMFU4ssbCzw2ZN6/I4HCn8PyTWTL6HNfXgMsxipqjtJm3KCIm5/hVjmUz9XXBgiTdf+K+GHgkOUA3P0kRLBGC0JVYd9ItGynwHxFnBPy/9yxU8l3iLFVSpHdd1GXqiZn+xk+Nk0e4Fegt7t0fpFVF5Ot9d6SRWt356yEwEVe72VQRm9KMdbpJAm5Ew6F4TiSP31FhD9c/UIQUhpBBXZCztxCRa7gLBQ8swwt3RN/vOvNSKwhIaYM+vPZLn09twb0ksJ2QqWY1u8pf/TVbgYXsLJ6ykvVNhP0OSlv7uehTpMLEqstUGQnY/TE704bqiCKYL3ddf+DSZdt7DY8EUp/fxUCLAp3auMu7EZJIr5FXwWKxn+IjxiII9rlAb2SC8zO1FexE4c7b8DLQvebl0q05kZUB8CI68MhsactVKrJRanXcYRilfd7VA100hYW0= moji@DESKTOP-B56ER7Q"







