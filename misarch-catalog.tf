resource "kubernetes_deployment" "misarch_catalog" {
  depends_on = [helm_release.misarch_catalog_db, helm_release.dapr]
  metadata {

    name = "misarch-catalog"
    labels = {
      app = "misarch-catalog"
    }
    namespace = local.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "misarch-catalog"
      }
    }

    template {
      metadata {
        labels = {
          app = "misarch-catalog"
        }
        annotations = merge(local.base_misarch_annotations, local.misarch_catalog_specific_annotations)
      }

      spec {

        container {
          image             = "ghcr.io/misarch/catalog:${var.MISARCH_CATALOG_VERSION}"
          image_pull_policy = "Always"

          name = "misarch-catalog"

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
              name = local.misarch_catalog_env_vars_configmap
            }
          }
        }
      }
    }
  }
}
