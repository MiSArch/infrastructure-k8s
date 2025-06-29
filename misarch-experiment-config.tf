resource "kubernetes_service" "misarch_experiment_config" {
  metadata {
    name      = local.misarch_experiment_config_service_name
    namespace = local.namespace
    labels    = merge(local.base_misarch_labels, local.misarch_experiment_config_specific_labels)
  }

  spec {
    selector = {
      app = local.misarch_experiment_config_service_name
    }

    port {
      name       = "http"
      port       = 80
      target_port = 8080
    }
  }
}

resource "kubernetes_deployment" "misarch_experiment_config" {
  depends_on = [terraform_data.dapr, kubernetes_deployment.keycloak]
  metadata {

    name      = local.misarch_experiment_config_service_name
    labels    = merge(local.base_misarch_labels, local.misarch_experiment_config_specific_labels)
    namespace = local.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = local.misarch_experiment_config_service_name
      }
    }

    template {
      metadata {
        labels      = merge(local.base_misarch_labels, local.misarch_experiment_config_specific_labels)
        annotations = merge(local.base_misarch_annotations, local.misarch_experiment_config_specific_annotations)
      }

      spec {

        container {
          image             = "ghcr.io/misarch/experiment-config:${var.MISARCH_EXPERIMENT_CONFIG_VERSION}"
          image_pull_policy = "Always"

          name = local.misarch_experiment_config_service_name

          resources {
            limits = {
              cpu    = "500m"
              memory = "1200Mi"
            }
            requests = {
              cpu    = "100m"
              memory = "400Mi"
            }
          }

          readiness_probe {
            tcp_socket {
              port = 8080
            }
            initial_delay_seconds = 30
            period_seconds        = 10
            failure_threshold     = 3
            success_threshold     = 1
            timeout_seconds       = 5
          }

          env_from {
            config_map_ref {
              name = local.misarch_base_env_vars_configmap
            }
          }
          env_from {
            config_map_ref {
              name = local.misarch_experiment_config_env_vars_configmap
            }
          }
        }
      }
    }
  }
}
