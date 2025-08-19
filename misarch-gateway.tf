resource "kubernetes_service" "misarch_gateway" {
  metadata {
    name      = local.misarch_gateway_service_name
    labels    = merge(local.base_misarch_labels, local.misarch_gateway_specific_labels)
    namespace = local.namespace
  }

  spec {
    selector = {
      app = local.misarch_gateway_service_name
    }

    port {
      name       = "http"
      port       = 8080
      target_port = 8080
    }
  }
}

resource "kubernetes_deployment" "misarch_gateway" {
  depends_on = [terraform_data.dapr]
  metadata {

    name      = local.misarch_gateway_service_name
    labels    = merge(local.base_misarch_labels, local.misarch_gateway_specific_labels)
    namespace = local.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = local.misarch_gateway_service_name
      }
    }

    template {
      metadata {
        labels      = merge(local.base_misarch_labels, local.misarch_gateway_specific_labels)
        annotations = merge(local.base_misarch_annotations, local.misarch_gateway_specific_annotations)
      }

      spec {

        container {
          image             = "ghcr.io/misarch/gateway:${var.MISARCH_GATEWAY_VERSION}"
          image_pull_policy = "Always"

          name = local.misarch_gateway_service_name

          resources {
            limits = {
              cpu    = "2400m"
              memory = "5Gi"
            }
            requests = {
              cpu    = "100m"
              memory = "200Mi"
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
              name = local.misarch_gateway_env_vars_configmap
            }
          }
        }

        container {
          image             = "ghcr.io/misarch/experiment-config-sidecar:${var.MISARCH_EXPERIMENT_CONFIG_SIDECAR_VERSION}"
          image_pull_policy = "Always"

          name = local.misarch_ecs_service_name

          resources {
            limits = {
              cpu    = "2000m"
              memory = "2Gi"
            }
            requests = {
              cpu    = "10m"
              memory = "50Mi"
            }
          }

          env_from {
            config_map_ref {
              name = local.misarch_gateway_ecs_env_vars_configmap
            }
          }
        }
      }
    }
  }
}
