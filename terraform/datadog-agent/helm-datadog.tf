terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.0"
    }
    datadog = {
      source  = "DataDog/datadog"
      version = ">= 3.0.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}

provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
  api_url = var.datadog_api_url
}

resource "kubernetes_namespace" "ds-devops-project-monitoring" {
  metadata {
    name = "ds-devops-project-monitoring"
  }
}

resource "helm_release" "datadog_agent" {
  name       = "datadog-agent"
  chart      = "datadog"
  repository = "https://helm.datadoghq.com"
  version    = "3.10.9"
  namespace  = kubernetes_namespace.ds-devops-project-monitoring.id

  set_sensitive = [
    {
      name  = "datadog.apiKey"
      value = var.datadog_api_key
    }
  ]

  set = [
    {
      name  = "datadog.site"
      value = var.datadog_site
    },
    {
      name  = "datadog.logs.enabled"
      value = "true"
    },
    {
      name  = "datadog.logs.containerCollectAll"
      value = "true"
    },
    {
      name  = "datadog.leaderElection"
      value = "true"
    },
    {
      name  = "datadog.collectEvents"
      value = "true"
    },
    {
      name  = "clusterAgent.enabled"
      value = "true"
    },
    {
      name  = "clusterAgent.metricsProvider.enabled"
      value = "true"
    },
    {
      name  = "networkMonitoring.enabled"
      value = "true"
    },
    {
      name  = "systemProbe.enableTCPQueueLength"
      value = "true"
    },
    {
      name  = "systemProbe.enableOOMKill"
      value = "true"
    },
    {
      name  = "securityAgent.runtime.enabled"
      value = "true"
    },
    {
      name  = "datadog.hostVolumeMountPropagation"
      value = "HostToContainer"
    },
    {
      name  = "datadog.env[0].name"
      value = "DD_EC2_PREFER_IMDSV2"
    },
    {
      name  = "datadog.env[0].value"
      value = "true"
    }
  ]
}
