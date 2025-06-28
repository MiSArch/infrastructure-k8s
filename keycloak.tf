resource "kubernetes_service" "keycloak" {
  metadata {
    name      = local.keycloak_service_name
    namespace = local.namespace
    labels    = merge(local.base_misarch_labels, local.misarch_keycloak_specific_labels)
  }

  spec {
    selector = {
      app = local.keycloak_service_name
    }

    port {
      name       = "http"
      port       = 80
      target_port = 8080
    }
  }
}

resource "kubernetes_deployment" "keycloak" {
  depends_on = [helm_release.misarch_keycloak_db, terraform_data.dapr]
  metadata {

    name      = local.keycloak_service_name
    labels    = merge(local.base_misarch_labels, local.misarch_keycloak_specific_labels)
    namespace = local.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = local.keycloak_service_name
      }
    }

    template {
      metadata {
        labels    = merge(local.base_misarch_labels, local.misarch_keycloak_specific_labels)
        annotations = merge(local.base_misarch_annotations, local.keycloak_specific_annotations)
      }

      spec {

        container {
          image             = "ghcr.io/misarch/keycloak:${var.MISARCH_KEYCLOAK_VERSION}"
          image_pull_policy = "Always"

          name = local.keycloak_service_name

          resources {
            limits = {
              cpu    = "2000m"
              memory = "2400Mi"
            }
            requests = {
              cpu    = "300m"
              memory = "500Mi"
            }
          }

          startup_probe {
            tcp_socket {
              port = 8080
            }
            initial_delay_seconds = 240
            period_seconds        = 10
            failure_threshold     = 10
            success_threshold     = 1
            timeout_seconds       = 5
          }

          readiness_probe {
            tcp_socket {
              port = 8080
            }
            initial_delay_seconds = 240
            period_seconds        = 10
            failure_threshold     = 10
            success_threshold     = 1
            timeout_seconds       = 5
          }

          env_from {
            config_map_ref {
              name = local.misarch_base_env_vars_configmap
            }
          }
          env_from {
            config_map_ref {
              name = local.keycloak_env_vars_configmap
            }
          }

          env {
            name  = "KC_DB_URL"
            value = "jdbc:postgresql://keycloak-db.misarch.svc.cluster.local:5432/keycloak"
          }
        }
      }
    }
  }
}

resource "kubernetes_secret" "keycloak_auth" {
  metadata {
    name      = "keycloak-auth"
    namespace = var.KUBERNETES_NAMESPACE
  }
  data = {
    adminUser     = "admin"
    adminPassword = var.KEYCLOAK_ADMIN_PASSWORD
  }
}

resource "kubernetes_config_map" "keycloak_metrics" {
  metadata {
    name      = "keycloak-metrics"
    namespace = var.KUBERNETES_NAMESPACE
  }
  data = {
    enabled = "true"
  }
}

# resource "kubernetes_persistent_volume_claim" "misarch_keycloak_plugin_volume" {
#   metadata {
#     name      = "misarch-keycloak-plugin-volume"
#     namespace = var.KUBERNETES_NAMESPACE
#   }
#   spec {
#     access_modes = ["ReadWriteOnce"]
#     resources {
#       requests = {
#         storage = "1M"
#       }
#     }
#   }
# }

# resource "kubernetes_config_map" "misarch_keycloak_realm_config" {
#   metadata {
#     name      = "misarch-keycloak-realm-config"
#     namespace = var.KUBERNETES_NAMESPACE
#   }
#   data = {
#     "misarch-realm.json" = file("keycloak/keycloak-realm-template.json")
#   }
# }
