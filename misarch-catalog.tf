locals {
  misarch_catalog_specific_annotations = {
    "dapr.io/app-id"    = "catalog"
    "dapr.io/app-port"  = 8080
  }
}

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
        annotations = {
          "dapr.io/enabled"   = true
          "dapr.io/app-id"    = "catalog"
          "dapr.io/app-port"  = 8080
          "dapr.io/http-port" = 3500
          "dapr.io/config"    = "/config.yaml",
        }
      }

      spec {

        container {
          image             = "ghcr.io/misarch/catalog:${var.MISARCH_CATALOG_VERSION}"
          image_pull_policy = "Always"

          name = "misarch-catalog"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "1500Mi"
            }
            requests = {
              cpu    = "0.15"
              memory = "500Mi"
            }
          }

          # TODO: Do I need these env vars?
          #      - SPRING_R2DBC_URL=r2dbc:postgresql://catalog-db:5432/catalog
          #      - SPRING_FLYWAY_URL=jdbc:postgresql://catalog-db:5432/catalog
          #      - SPRING_PROFILES_ACTIVE=dev

          env {
            name  = "SPRING_DATASOURCE_URL"
            value = "jdbc:postgresql://content-service-db-postgresql:5432/content-service"
          }

          env {
            name  = "SPRING_DATASOURCE_USERNAME"
            value = "gits"
          }

          env {
            name  = "SPRING_DATASOURCE_PASSWORD"
            value = random_password.misarch_catalog_db_password.result
          }

          # TODO: wget http://localhost:8080/graphiql || exit 1
          liveness_probe {
            http_get {
              path = "/actuator/health/liveness"
              port = 8080

            }

            initial_delay_seconds = 30
            period_seconds        = 10
          }

          readiness_probe {
            http_get {
              path = "/actuator/health/readiness"
              port = 8080

            }

            initial_delay_seconds = 30
            period_seconds        = 10
          }
        }
      }
    }
  }
}

resource "helm_release" "misarch_catalog_db" {
  name       = "misarch-catalog-db"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "postgresql"
  namespace  = local.namespace

  set {
    name  = "global.postgresql.auth.database"
    value = "catalog"
  }

  set {
    name  = "postgres.auth.enablePostgresUser"
    value = "true"
  }

  /* # TODO: Fix db user
  set {
    name  = "global.postgresql.auth.username"
    value = "gits"
  }*/

  # TODO: That won't work, the service requires password "postgres"
  set {
    name  = "global.postgresql.auth.password"
    value = random_password.misarch_catalog_db_password.result
  }
}
