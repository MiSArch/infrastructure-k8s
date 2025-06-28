resource "kubernetes_deployment" "misarch_frontend" {
  depends_on = [terraform_data.dapr, kubernetes_deployment.keycloak]
  metadata {

    name      = local.misarch_frontend_service_name
    labels    = merge(local.base_misarch_labels, local.misarch_frontend_specific_labels)
    namespace = local.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = local.misarch_frontend_service_name
      }
    }

    template {
      metadata {
        labels      = merge(local.base_misarch_labels, local.misarch_frontend_specific_labels)
        annotations = merge(local.base_misarch_annotations, local.misarch_frontend_specific_annotations)
      }

      spec {

        container {
          image             = "ghcr.io/misarch/frontend:${var.MISARCH_FRONTEND_VERSION}"
          image_pull_policy = "Always"

          name = local.misarch_frontend_service_name

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
              name = local.misarch_frontend_env_vars_configmap
            }
          }
        }
      }
    }
  }
}
