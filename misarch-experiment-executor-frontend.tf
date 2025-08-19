resource "kubernetes_service" "misarch_experiment_executor_frontend" {
  metadata {
    name      = local.misarch_experiment_executor_frontend_service_name
    labels    = merge(local.base_misarch_labels, local.misarch_experiment_executor_frontend_specific_labels)
    namespace = local.namespace
  }

  spec {
    selector = {
      app = local.misarch_experiment_executor_frontend_service_name
    }

    port {
      name       = "http"
      port       = 80
      target_port = 80
    }
  }
}

resource "kubernetes_deployment" "misarch_experiment_executor_frontend" {
  metadata {

    name      = local.misarch_experiment_executor_frontend_service_name
    labels    = merge(local.base_misarch_labels, local.misarch_experiment_executor_frontend_specific_labels)
    namespace = local.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = local.misarch_experiment_executor_frontend_service_name
      }
    }

    template {
      metadata {
        labels      = merge(local.base_misarch_labels, local.misarch_experiment_executor_frontend_specific_labels)
      }

      spec {

        container {
          image             = "ghcr.io/misarch/experiment-executor-frontend:${var.MISARCH_EXPERIMENT_EXECUTOR_FRONTEND_VERSION}"
          image_pull_policy = "Always"

          name = local.misarch_experiment_executor_frontend_service_name

          resources {
            limits = {
              cpu    = "100m"
              memory = "200Mi"
            }
            requests = {
              cpu    = "10m"
              memory = "50Mi"
            }
          }

          env_from {
            config_map_ref {
              name = local.misarch_base_env_vars_configmap
            }
          }
          env_from {
            config_map_ref {
              name = local.misarch_experiment_executor_frontend_env_vars_configmap
            }
          }
        }
      }
    }
  }
}
