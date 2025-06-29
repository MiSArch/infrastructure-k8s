resource "kubernetes_deployment" "misarch_payment" {
  depends_on = [helm_release.misarch_payment_db, terraform_data.dapr]
  metadata {

    name      = local.misarch_payment_service_name
    labels    = merge(local.base_misarch_labels, local.misarch_payment_specific_labels)
    namespace = local.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = local.misarch_payment_service_name
      }
    }

    template {
      metadata {
        labels      = merge(local.base_misarch_labels, local.misarch_payment_specific_labels)
        annotations = merge(local.base_misarch_annotations, local.misarch_payment_specific_annotations)
      }

      spec {

        container {
          image             = "ghcr.io/misarch/payment:${var.MISARCH_PAYMENT_VERSION}"
          image_pull_policy = "Always"

          name = local.misarch_payment_service_name


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

          env_from {
            config_map_ref {
              name = local.misarch_base_env_vars_configmap
            }
          }
          env_from {
            config_map_ref {
              name = local.misarch_payment_env_vars_configmap
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
              name = local.misarch_payment_ecs_env_vars_configmap
            }
          }
        }
      }
    }
  }
}
