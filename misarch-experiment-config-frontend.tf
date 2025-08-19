resource "kubernetes_service" "misarch_experiment_config_frontend" {
  metadata {
    name      = "misarch-experiment-config-frontend"
    namespace = local.namespace
    labels = merge(local.base_misarch_labels, { app = "misarch-experiment-config-frontend" })
  }

  spec {
    selector = { app = "misarch-experiment-config-frontend" }

    port {
      name        = "http"
      port        = 80
      target_port = 80
    }
  }
}

resource "kubernetes_deployment" "misarch_experiment_config_frontend" {
  depends_on = [kubernetes_deployment.misarch_experiment_config]
  metadata {

    name      = "misarch-experiment-config-frontend"
    labels = merge(local.base_misarch_labels, { app = "misarch-experiment-config-frontend" })
    namespace = local.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "misarch-experiment-config-frontend"
      }
    }

    template {
      metadata {
        labels = merge(local.base_misarch_labels, { app = "misarch-experiment-config-frontend" })
        annotations = merge(local.base_misarch_annotations, { "dapr.io/enabled" = "false" })
      }

      spec {

        container {
          image             = "ghcr.io/misarch/experiment-config-frontend:main"
          image_pull_policy = "Always"

          name = "misarch-experiment-config-frontend"

          resources {
            limits = {
              cpu    = "100m"
              memory = "100Mi"
            }
            requests = {
              cpu    = "40m"
              memory = "50Mi"
            }
          }

          env {
            name  = "EXPERIMENT_CONFIG_ENDPOINT"
            value = "misarch-experiment-config.misarch.svc.cluster.local"
          }
        }
      }
    }
  }
}
