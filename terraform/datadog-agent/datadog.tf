# terraform {
#   required_providers {
#     datadog = {
#       source = "DataDog/datadog"
#     }
#     helm = {
#       source = "hashicorp/helm"
#     }
#   }
# }


# terraform {
#   required_providers {
#     helm = {
#       source  = "hashicorp/helm"
#       version = ">= 2.0.0"
#     }
#     kubernetes = {
#       source  = "hashicorp/kubernetes"
#       version = ">= 2.0.0"
#     }
#     datadog = {
#       source  = "DataDog/datadog"
#       version = ">= 3.0.0"
#     }
#   }
# }

# terraform {
#   required_providers {
#     helm = {
#       source  = "hashicorp/helm"
#       version = ">= 2.0.0"
#     }
#     kubernetes = {
#       source  = "hashicorp/kubernetes"
#       version = ">= 2.0.0"
#     }
#     datadog = {
#       source  = "DataDog/datadog"
#       version = ">= 3.0.0"
#     }
#   }
# }



# terraform {
#   required_providers {
#     datadog = {
#       source = "DataDog/datadog"
#     }
#   }
# }

# provider "datadog" {
#   api_key = var.datadog_api_key
#   app_key = var.datadog_app_key
#   api_url = var.datadog_api_url
# }

/*provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "kubernetes_namespace" "datascientest-monioring" {
  metadata {
    name = "datascientest-monioring"
  }
}

resource "helm_release" "datadog_agent" {
  name       = "datadog-agent"
  chart      = "datadog"
  repository = "https://helm.datadoghq.com"
  version    = "3.10.9"
  namespace  = kubernetes_namespace.datascientest-monioring.id

  set_sensitive {
    name  = "datadog.apiKey"
    value = var.datadog_api_key
  }
  set {
    name  = "datadog.site"
    value = var.datadog_site
  }
  # ... (other set blocks as needed)
}*/
