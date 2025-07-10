variable "cluster_name" {}
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
}
