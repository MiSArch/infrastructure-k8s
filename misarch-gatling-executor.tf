resource "kubernetes_service" "misarch_gatling_executor" {
  metadata {
    name      = local.misarch_gatling_executor_service_name
    labels    = merge(local.base_misarch_labels, local.misarch_gatling_executor_specific_labels)
    namespace = local.namespace
  }

  spec {
    selector = {
      app = local.misarch_gatling_executor_service_name
    }

    port {
      name       = "http"
      port       = 8889
      target_port = 8889
    }
  }
}

resource "kubernetes_deployment" "misarch_gatling_executor" {
  metadata {

    name      = local.misarch_gatling_executor_service_name
    labels    = merge(local.base_misarch_labels, local.misarch_gatling_executor_specific_labels)
    namespace = local.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = local.misarch_gatling_executor_service_name
      }
    }

    template {
      metadata {
        labels      = merge(local.base_misarch_labels, local.misarch_gatling_executor_specific_labels)
      }

      spec {

        container {
          image             = "ghcr.io/misarch/gatling-executor:${var.MISARCH_GATLING_EXECUTOR_VERSION}"
          image_pull_policy = "Always"

          name = local.misarch_gatling_executor_service_name

          resources {
            limits = {
              cpu    = "5000m"
              memory = "5Gi"
            }
            requests = {
              cpu    = "100m"
              memory = "500Mi"
            }
          }

          env_from {
            config_map_ref {
              name = local.misarch_base_env_vars_configmap
            }
          }
          env_from {
            config_map_ref {
              name = local.misarch_gatling_executor_env_vars_configmap
            }
          }
        }
      }
    }
  }
}
