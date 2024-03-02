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
        annotations = merge(var.BASE_MISARCH_ANNOTATIONS, var.MISARCH_CATALOG_SPECIFIC_ANNOTATIONS)
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

          env {
            name  = "SPRING_R2DBC_URL"
            value = "r2dbc:postgresql://${local.catalog_db_url}/${var.MISARCH_DB_DATABASE}"
          }

          env {
            name  = "SPRING_FLYWAY_URL"
            value = "jdbc:postgresql://${local.catalog_db_url}/${var.MISARCH_DB_DATABASE}"
          }

          env {
            name  = "SPRING_PROFILES_ACTIVE"
            value = "dev"
          }

          env {
            name  = "SPRING_R2DBC_USERNAME"
            value = var.MISARCH_DB_USER
          }

          env {
            name  = "SPRING_R2DBC_PASSWORD"
            value = random_password.misarch_catalog_db_password.result
          }

          # liveness_probe {
          #   http_get {
          #     path = "/graphiql"
          #     port = 8080
          #   }
          # }
        }
      }
    }
  }
}
