# creation of the namespace of the resource
# resource "kubernetes_namespace" "ds_devops_project_namespace" {
#   metadata {
#     name = "ds-devops-project-namespace" # underline is not allowed in the name
#   }
# }

# creation of a deployment named datascientest-deploy
# Namespace block is removed  Do NOT include kubernetes_namespace resource

#  Deployment in default namespace (no namespace declared)
resource "kubernetes_deployment" "ds_devops_monitoring_deploy" {
  metadata {
    name = var.application_name
    labels = {
      app = var.application_name
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = var.application_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.application_name
        }
      }

      spec {
        container {
          name  = var.application_name
          image = "nginx:latest"
        }
      }
    }
  }
}

#  Service in default namespace (no dynamic reference to namespace)
resource "kubernetes_service" "ds_devops_monitoring_service" {
  metadata {
    name = var.application_name
    #  Remove namespace reference if it depended on a deleted resource
    #  Leave it out to use the "default" namespace
  }

  spec {
    selector = {
      app = kubernetes_deployment.ds_devops_monitoring_deploy.metadata[0].labels.app
    }

    port {
      port        = 8080
      target_port = 80
    }

    type = "NodePort"
  }
}
