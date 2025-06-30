resource "kubernetes_service" "misarch_experiment_executor" {
  metadata {
    name      = local.misarch_experiment_executor_service_name
    labels    = merge(local.base_misarch_labels, local.misarch_experiment_executor_specific_labels)
    namespace = local.namespace
  }

  spec {
    selector = {
      app = local.misarch_experiment_executor_service_name
    }

    port {
      name       = "http"
      port       = 8888
      target_port = 8888
    }
  }
}

resource "kubernetes_deployment" "misarch_experiment_executor" {
  metadata {

    name      = local.misarch_experiment_executor_service_name
    labels    = merge(local.base_misarch_labels, local.misarch_experiment_executor_specific_labels)
    namespace = local.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = local.misarch_experiment_executor_service_name
      }
    }

    template {
      metadata {
        labels      = merge(local.base_misarch_labels, local.misarch_experiment_executor_specific_labels)
      }

      spec {

        container {
          image             = "ghcr.io/misarch/experiment-executor:${var.MISARCH_EXPERIMENT_EXECUTOR_VERSION}"
          image_pull_policy = "Always"

          name = local.misarch_experiment_executor_service_name

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

          env_from {
            config_map_ref {
              name = local.misarch_base_env_vars_configmap
            }
          }
          env_from {
            config_map_ref {
              name = local.misarch_experiment_executor_env_vars_configmap
            }
          }

          volume_mount {
            name       = "experiment-executor-storage"
            mount_path = "/home/java/tests"
          }
        }

        volume {
          name = "experiment-executor-storage"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.misarch_experiment_executor_pvc.metadata[0].name
          }
        }
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "misarch_experiment_executor_pvc" {
  metadata {
    name      = "${local.misarch_experiment_executor_service_name}-pvc"
    namespace = local.namespace
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
  }
}