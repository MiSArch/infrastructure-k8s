resource "kubernetes_deployment" "misarch_shoppingcart" {
  depends_on = [helm_release.misarch_shoppingcart_db, terraform_data.dapr]
  metadata {

    name      = local.misarch_shoppingcart_service_name
    labels    = merge(local.base_misarch_labels, local.misarch_shoppingcart_specific_labels)
    namespace = local.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = local.misarch_shoppingcart_service_name
      }
    }

    template {
      metadata {
        labels      = merge(local.base_misarch_labels, local.misarch_shoppingcart_specific_labels)
        annotations = merge(local.base_misarch_annotations, local.misarch_shoppingcart_specific_annotations)
      }

      spec {

        container {
          image             = "ghcr.io/misarch/shoppingcart:${var.MISARCH_SHOPPINGCART_VERSION}"
          image_pull_policy = "Always"

          name = local.misarch_shoppingcart_service_name


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
              name = local.misarch_shoppingcart_env_vars_configmap
            }
          }
        }
      }
    }
  }
}
