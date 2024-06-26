resource "kubernetes_deployment" "misarch_review" {
  depends_on = [helm_release.misarch_review_db, terraform_data.dapr]
  metadata {

    name      = local.misarch_review_service_name
    labels    = merge(local.base_misarch_labels, local.misarch_review_specific_labels)
    namespace = local.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = local.misarch_review_service_name
      }
    }

    template {
      metadata {
        labels      = merge(local.base_misarch_labels, local.misarch_review_specific_labels)
        annotations = merge(local.base_misarch_annotations, local.misarch_review_specific_annotations)
      }

      spec {

        container {
          image             = "ghcr.io/misarch/review:${var.MISARCH_REVIEW_VERSION}"
          image_pull_policy = "Always"

          name = local.misarch_review_service_name


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
              name = local.misarch_review_env_vars_configmap
            }
          }
        }
      }
    }
  }
}
