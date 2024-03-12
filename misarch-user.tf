resource "kubernetes_deployment" "misarch_user" {
  depends_on = [helm_release.misarch_user_db, terraform_data.dapr]
  metadata {

    name      = local.misarch_user_service_name
    labels    = merge(local.base_misarch_labels, local.misarch_user_specific_labels)
    namespace = local.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = local.misarch_user_service_name
      }
    }

    template {
      metadata {
        labels      = merge(local.base_misarch_labels, local.misarch_user_specific_labels)
        annotations = merge(local.base_misarch_annotations, local.misarch_user_specific_annotations)
      }

      spec {

        container {
          image             = "ghcr.io/misarch/user:${var.MISARCH_USER_VERSION}"
          image_pull_policy = "Always"

          name = local.misarch_user_service_name

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
              name = local.misarch_user_env_vars_configmap
            }
          }
        }
      }
    }
  }
}
