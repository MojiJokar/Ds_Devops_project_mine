# terraform {
#   required_providers {
#     datadog = {
#       source = "DataDog/datadog"
#     }
#   }
# }

# terraform {
#   required_providers {
#     helm = {
#       source  = "hashicorp/helm"
#       version = ">= 3.0.2"
#     }
#     kubernetes = {
#       source  = "hashicorp/kubernetes"
#       version = ">= 2.26.0"
#     }
#     datadog = {
#       source  = "datadog/datadog"
#       version = ">= 3.0.0"
#     }
#   }
# }





# # Configure the Datadog provider
# provider "datadog" {
#   api_key = var.datadog_api_key
#   app_key = var.datadog_app_key
#   api_url = var.datadog_api_url
# }