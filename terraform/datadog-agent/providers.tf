# terraform {
#   required_providers {
#     kubernetes = {
#       source  = "hashicorp/kubernetes"
#       version = ">= 2.26.0"
#     }
#     helm = {
#       source  = "hashicorp/helm"
#       version = ">= 3.0.2"
#     }
#     datadog = {
#       source  = "datadog/datadog"
#       version = ">= 3.0.0"
#     }
#   }
# }

# provider "kubernetes" {
#   config_path = "~/.kube/config"
# }




# provider "datadog" {
#   api_key = var.datadog_api_key
#   app_key = var.datadog_app_key
#   api_url = var.datadog_api_url
# }
