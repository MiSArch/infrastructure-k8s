resource "kubernetes_deployment" "misarch_experiment_config" {
  depends_on = [terraform_data.dapr, helm_release.keycloak]
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
