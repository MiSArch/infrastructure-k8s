resource "kubernetes_deployment" "misarch_frontend" {
  metadata {
    name = "misarch-frontend"
    labels = {
      app = "misarch-frontend"
    }
    namespace = kubernetes_namespace.misarch.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "misarch-frontend"
      }
    }

    template {
      metadata {
        labels = {
          app = "misarch-frontend"
        }
      }

      spec {
        image_pull_secrets {
          name = kubernetes_secret.image_pull.metadata[0].name
        }

        container {
          image             = "ghcr.io/misarch/frontend:latest"
          image_pull_policy = "Always"

          name = "misarch-frontend"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "0.2"
              memory = "150Mi"
            }
          }

          env {
            name  = "GATEWAY_ENDPOINT"
            value = "/api"
          }
          env {
            name  = "PUBLIC_OAUTH_REDIRECT_URL"
            value = var.root_domain
          }
          env {
            name  = "PUBLIC_OAUTH_CLIENT_ID"
            value = "misarch-frontend"
          }
          env {
            name  = "PUBLIC_OAUTH_AUTHORITY"
            value = var.root_domain + "/keycloak/realms/misarch"
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 3000

            }

            initial_delay_seconds = 10
            period_seconds        = 10
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "misarch_frontend" {
  metadata {
    name      = "misarch-frontend"
    namespace = kubernetes_namespace.misarch.metadata[0].name
  }
  spec {
    selector = {
      app = kubernetes_deployment.misarch_frontend.metadata[0].labels.app
    }

    port {
      port        = 80
      target_port = 3000
    }

    type = "NodePort"
  }
}

