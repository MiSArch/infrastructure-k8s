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
              cpu    = "600m"
              memory = "2400Mi"
            }
            requests = {
              cpu    = "200m"
              memory = "1200Mi"
            }
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
      }
    }
  }
}
