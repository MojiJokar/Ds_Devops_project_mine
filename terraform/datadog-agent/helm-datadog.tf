# Kubernetes Namespace
# resource "kubernetes_namespace" "ds_devops_monitoring" {
#   metadata {
#     name = "ds-devops-project-monitoring"
#   }
# }

# Helm Release: Datadog Agent
resource "helm_release" "datadog_agent" {
  name       = "datadog-agent"
  chart      = "datadog"
  repository = "https://helm.datadoghq.com"
  version    = "3.10.9"
  #namespace  = kubernetes_namespace.ds_devops_monitoring.metadata[0].name

  set = [
    {
      name  = "datadog.apiKey"
      value = var.datadog_api_key
    },
    {
      name  = "datadog.site"
      value = var.datadog_site
    },
    {
      name  = "datadog.logs.enabled"
      value = true
    },
    {
      name  = "datadog.logs.containerCollectAll"
      value = true
    },
    {
      name  = "datadog.leaderElection"
      value = true
    },
    {
      name  = "datadog.collectEvents"
      value = true
    },
    {
      name  = "clusterAgent.enabled"
      value = true
    },
    {
      name  = "clusterAgent.metricsProvider.enabled"
      value = true
    },
    {
      name  = "networkMonitoring.enabled"
      value = true
    },
    {
      name  = "systemProbe.enableTCPQueueLength"
      value = true
    },
    {
      name  = "systemProbe.enableOOMKill"
      value = true
    },
    {
      name  = "securityAgent.runtime.enabled"
      value = true
    },
    {
      name  = "datadog.hostVolumeMountPropagation"
      value = "HostToContainer"
    }
  ]
}






















####################################
# Terraform Provider Requirements
####################################
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

# ####################################
# # Provider Configurations
# ####################################

# provider "kubernetes" {
#   config_path = "~/.kube/config"
# }

# provider "helm" {
#   # Uses same kubeconfig context as kubernetes provider
# }

# provider "datadog" {
#   api_key = var.datadog_api_key
#   app_key = var.datadog_app_key
#   api_url = var.datadog_api_url
# }

####################################
# Variables
####################################

# variable "datadog_api_key" {
#   type        = string
#   description = "Datadog API Key used for the deployment"
#   default     = "9bef7693c3fee1874ac793162d7ac55c"
#   sensitive   = true
# }

# variable "datadog_app_key" {
#   type        = string
#   description = "Datadog Application Key"
#   default     = "550e61c08c29657b3f870e7e01983a9e18c4865a"
#   sensitive   = true
# }

# variable "datadog_site" {
#   type        = string
#   description = "Datadog Site (e.g., datadoghq.eu or datadoghq.com)"
#   default     = "datadoghq.eu"
# }

# variable "datadog_api_url" {
#   type        = string
#   description = "Datadog API endpoint URL"
#   default     = "https://api.datadoghq.eu"
# }

####################################
# Kubernetes Namespace Definition
####################################

# resource "kubernetes_namespace" "ds_devops_monitoring" {
#   metadata {
#     name = "ds-devops-project-monitoring"
#   }
# }

# ####################################
# # Helm Chart: Datadog Agent Release
# ####################################

# resource "helm_release" "datadog_agent" {
#   name       = "datadog-agent"
#   chart      = "datadog"
#   repository = "https://helm.datadoghq.com"
#   version    = "3.10.9"
#   namespace  = kubernetes_namespace.ds_devops_monitoring.metadata[0].name

#   set = [
#     {
#       name  = "datadog.apiKey"
#       value = var.datadog_api_key
#     },
#     {
#       name  = "datadog.site"
#       value = var.datadog_site
#     },
#     {
#       name  = "datadog.logs.enabled"
#       value = true
#     },
#     {
#       name  = "datadog.logs.containerCollectAll"
#       value = true
#     },
#     {
#       name  = "datadog.leaderElection"
#       value = true
#     },
#     {
#       name  = "datadog.collectEvents"
#       value = true
#     },
#     {
#       name  = "clusterAgent.enabled"
#       value = true
#     },
#     {
#       name  = "clusterAgent.metricsProvider.enabled"
#       value = true
#     },
#     {
#       name  = "networkMonitoring.enabled"
#       value = true
#     },
#     {
#       name  = "systemProbe.enableTCPQueueLength"
#       value = true
#     },
#     {
#       name  = "systemProbe.enableOOMKill"
#       value = true
#     },
#     {
#       name  = "securityAgent.runtime.enabled"
#       value = true
#     },
#     {
#       name  = "datadog.hostVolumeMountPropagation"
#       value = "HostToContainer"
#     }
#   ]
# }





























# # terraform {
# #   required_providers {
# #     helm = {
# #       source  = "hashicorp/helm"
# #       version = ">= 3.0.2"
# #     }
# #     kubernetes = {
# #       source  = "hashicorp/kubernetes"
# #       version = ">= 2.26.0"
# #     }
# #     datadog = {
# #       source  = "datadog/datadog"
# #       version = ">= 3.0.0"
# #     }
# #   }
# # }

# ####################################
# # Provider Configurations (define each only once!)
# ####################################

# provider "kubernetes" {
#   config_path = "~/.kube/config"
# }

# provider "helm" {
#   # No kubernetes block needed here for v3+
# }

# # provider "datadog" {
# #   api_key = var.datadog_api_key
# #   app_key = var.datadog_app_key
# #   api_url = var.datadog_api_url
# # }

# ####################################
# # Variable Definitions (define each only once!)
# ####################################

# # variable "datadog_api_key" {
# #   type        = string
# #   description = "Datadog API Key used for the deployment"
# #   default     = "9bef7693c3fee1874ac793162d7ac55c"
# #   sensitive   = true
# # }

# # variable "datadog_app_key" {
# #   type        = string
# #   description = "Datadog Application Key"
# #   default     = "550e61c08c29657b3f870e7e01983a9e18c4865a"
# #   sensitive   = true
# # }

# # variable "datadog_site" {
# #   type        = string
# #   description = "Datadog Site (e.g., datadoghq.eu or datadoghq.com)"
# #   default     = "datadoghq.eu"
# # }

# # variable "datadog_api_url" {
# #   type        = string
# #   description = "Datadog API endpoint URL"
# #   default     = "https://api.datadoghq.eu"
# # }

# ####################################
# # Kubernetes Namespace
# ####################################

# resource "kubernetes_namespace" "ds_devops_monitoring" {
#   metadata {
#     name = "ds-devops-project-monitoring"
#   }
# }

# ####################################
# # Datadog Agent Installation via Helm
# ####################################

# resource "helm_release" "datadog_agent" {
#   name       = "datadog-agent"
#   chart      = "datadog"
#   repository = "https://helm.datadoghq.com"
#   version    = "3.10.9"
#   #namespace  = kubernetes_namespace.ds_devops_monitoring.metadata[0].name
#   namespace  = kubernetes_namespace.ds_devops_monitoring.id

#   set = [
#     {
#       name  = "datadog.apiKey"
#       value = var.datadog_api_key
#     },
#     {
#       name  = "datadog.site"
#       value = var.datadog_site
#     },
#     {
#       name  = "datadog.logs.enabled"
#       value = true
#     },
#     {
#       name  = "datadog.logs.containerCollectAll"
#       value = true
#     },
#     {
#       name  = "datadog.leaderElection"
#       value = true
#     },
#     {
#       name  = "datadog.collectEvents"
#       value = true
#     },
#     {
#       name  = "clusterAgent.enabled"
#       value = true
#     },
#     {
#       name  = "clusterAgent.metricsProvider.enabled"
#       value = true
#     },
#     {
#       name  = "networkMonitoring.enabled"
#       value = true
#     },
#     {
#       name  = "systemProbe.enableTCPQueueLength"
#       value = true
#     },
#     {
#       name  = "systemProbe.enableOOMKill"
#       value = true
#     },
#     {
#       name  = "securityAgent.runtime.enabled"
#       value = true
#     },
#     {
#       name  = "datadog.hostVolumeMountPropagation"
#       value = "HostToContainer"
#     }
#   ]
# }
