output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.vpc.private_subnets
}

# Uncomment and customize additional outputs as needed
# output "ecr_repository_urls" {
#   description = "URLs of the ECR repositories"
#   value       = module.ecr.repository_urls
# }
output "cluster_name" {
  value       = module.eks.cluster_name
  description = "The name of the EKS cluster"
}
