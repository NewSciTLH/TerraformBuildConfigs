# Retrieve an access token as the Terraform runner
data "google_client_config" "provider" {}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

data "google_container_cluster" "primary" {
  name     = "call-sim-frontend"
  location = var.location
}

provider "kubernetes" {
  load_config_file = false

  host  = "https://${data.google_container_cluster.primary.endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
}

resource "kubernetes_deployment" "container" {
  metadata {
    name = "call-sim-frontend-prod-container"
    labels = {
      App = "call-sim-frontend-prod-container"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "call-sim-frontend-prod-container"
      }
    }
    template {
      metadata {
        labels = {
          App = "call-sim-frontend-prod-container"
        }
      }
      spec {
        container {
          image = var.container_image
          name  = "call-sim-frontend"
          env_from {
            secret_ref {
              name = "servacckey"
            }
          }

          port {
            container_port = 80
          }

          # resources {
          #   limits {
          #     cpu    = "0.5"
          #     memory = "512Mi"
          #   }
          #   requests {
          #     cpu    = "250m"
          #     memory = "50Mi"
          #   }
          # }
        }
      }
    }
  }
}

resource "kubernetes_service" "loadbalancer" {
  metadata {
    name = "call-sim-frontend-prod-loadbalancer"
  }
  spec {
    selector = {
      App = kubernetes_deployment.container.spec.0.template.0.metadata[0].labels.App
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}