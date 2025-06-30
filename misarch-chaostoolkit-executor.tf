resource "kubernetes_service" "misarch_chaostoolkit_executor" {
  metadata {
    name      = local.misarch_chaostoolkit_executor_service_name
    labels    = merge(local.base_misarch_labels, local.misarch_chaostoolkit_executor_specific_labels)
    namespace = local.namespace
  }

  spec {
    selector = {
      app = local.misarch_chaostoolkit_executor_service_name
    }

    port {
      name       = "http"
      port       = 8890
      target_port = 8890
    }
  }
}

resource "kubernetes_deployment" "misarch_chaostoolkit_executor" {
  metadata {

    name      = local.misarch_chaostoolkit_executor_service_name
    labels    = merge(local.base_misarch_labels, local.misarch_chaostoolkit_executor_specific_labels)
    namespace = local.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = local.misarch_chaostoolkit_executor_service_name
      }
    }

    template {
      metadata {
        labels      = merge(local.base_misarch_labels, local.misarch_chaostoolkit_executor_specific_labels)
      }

      spec {

        service_account_name = kubernetes_service_account.misarch_chaostoolkit_executor.metadata[0].name
        container {
          image             = "ghcr.io/misarch/chaostoolkit-executor:${var.MISARCH_CHAOSTOOLKIT_EXECUTOR_VERSION}"
          image_pull_policy = "Always"

          name = local.misarch_chaostoolkit_executor_service_name

          resources {
            limits = {
              cpu    = "500m"
              memory = "500Mi"
            }
            requests = {
              cpu    = "10m"
              memory = "50Mi"
            }
          }

          env_from {
            config_map_ref {
              name = local.misarch_base_env_vars_configmap
            }
          }
          env_from {
            config_map_ref {
              name = local.misarch_chaostoolkit_executor_env_vars_configmap
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_cluster_role" "misarch_chaostoolkit_executor" {
  metadata {
    name = local.misarch_chaostoolkit_executor_service_name
  }

  rule {
    api_groups = ["*"]
    resources  = ["*"]
    verbs      = ["*"]
  }
}

resource "kubernetes_service_account" "misarch_chaostoolkit_executor" {
  metadata {
    name      = local.misarch_chaostoolkit_executor_service_name
    namespace = local.namespace
  }
}

resource "kubernetes_cluster_role_binding" "misarch_chaostoolkit_executor" {
  metadata {
    name = "${local.misarch_chaostoolkit_executor_service_name}-binding"
  }

  role_ref {
    kind     = "ClusterRole"
    name     = kubernetes_cluster_role.misarch_chaostoolkit_executor.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.misarch_chaostoolkit_executor.metadata[0].name
    namespace = local.namespace
  }
}