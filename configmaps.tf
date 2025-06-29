locals {
  misarch_base_env_vars_configmap = "misarch-base-env-vars"

  keycloak_env_vars_configmap             = "keycloak-custom-env-vars"
  minio_env_vars_configmap                = "minio-env-vars"
  misarch_address_env_vars_configmap      = "misarch-address-env-vars"
  misarch_catalog_env_vars_configmap      = "misarch-catalog-env-vars"
  misarch_discount_env_vars_configmap     = "misarch-discount-env-vars"
  misarch_experiment_config_env_vars_configmap     = "misarch-experiment-config-env-vars"
  misarch_frontend_env_vars_configmap     = "misarch-frontend-env-vars"
  misarch_gateway_env_vars_configmap      = "misarch-gateway-env-vars"
  misarch_inventory_env_vars_configmap    = "misarch-inventory-env-vars"
  misarch_invoice_env_vars_configmap      = "misarch-invoice-env-vars"
  misarch_media_env_vars_configmap        = "misarch-media-env-vars"
  misarch_notification_env_vars_configmap = "misarch-notification-env-vars"
  misarch_order_env_vars_configmap        = "misarch-order-env-vars"
  misarch_payment_env_vars_configmap      = "misarch-payment-env-vars"
  misarch_review_env_vars_configmap       = "misarch-review-env-vars"
  misarch_return_env_vars_configmap       = "misarch-return-env-vars"
  misarch_shipment_env_vars_configmap     = "misarch-shipment-env-vars"
  misarch_shoppingcart_env_vars_configmap = "misarch-shoppingcart-env-vars"
  misarch_simulation_env_vars_configmap = "misarch-simulation-env-vars"
  misarch_tax_env_vars_configmap          = "misarch-tax-env-vars"
  #misarch_testdata_env_vars_configmap    = "misarch-testdata-env-vars"
  misarch_user_env_vars_configmap         = "misarch-user-env-vars"
  misarch_wishlist_env_vars_configmap     = "misarch-wishlist-env-vars"
  rabbitmq_env_vars_configmap             = "rabbitmq-env-vars"

  keycloak_ecs_env_vars_configmap             = "keycloak-ecs-env-vars"
  misarch_address_ecs_env_vars_configmap      = "misarch-address-ecs-env-vars"
  misarch_catalog_ecs_env_vars_configmap      = "misarch-catalog-ecs-env-vars"
  misarch_discount_ecs_env_vars_configmap     = "misarch-discount-ecs-env-vars"
  misarch_frontend_ecs_env_vars_configmap     = "misarch-frontend-ecs-env-vars"
  misarch_gateway_ecs_env_vars_configmap      = "misarch-gateway-ecs-env-vars"
  misarch_inventory_ecs_env_vars_configmap    = "misarch-inventory-ecs-env-vars"
  misarch_invoice_ecs_env_vars_configmap      = "misarch-invoice-ecs-env-vars"
  misarch_media_ecs_env_vars_configmap        = "misarch-media-ecs-env-vars"
  misarch_notification_ecs_env_vars_configmap = "misarch-notification-ecs-env-vars"
  misarch_order_ecs_env_vars_configmap        = "misarch-order-ecs-env-vars"
  misarch_payment_ecs_env_vars_configmap      = "misarch-payment-ecs-env-vars"
  misarch_return_ecs_env_vars_configmap       = "misarch-return-ecs-env-vars"
  misarch_review_ecs_env_vars_configmap       = "misarch-review-ecs-env-vars"
  misarch_shipment_ecs_env_vars_configmap     = "misarch-shipment-ecs-env-vars"
  misarch_shoppingcart_ecs_env_vars_configmap = "misarch-shoppingcart-ecs-env-vars"
  misarch_simulation_ecs_env_vars_configmap   = "misarch-simulation-ecs-env-vars"
  misarch_tax_ecs_env_vars_configmap          = "misarch-tax-ecs-env-vars"
  misarch_user_ecs_env_vars_configmap         = "misarch-user-ecs-env-vars"
  misarch_wishlist_ecs_env_vars_configmap     = "misarch-wishlist-ecs-env-vars"
}

resource "kubernetes_config_map" "base_misarch_env_vars" {
  metadata {
    name      = local.misarch_base_env_vars_configmap
    namespace = local.namespace
  }
}

resource "kubernetes_config_map" "keycloak_env_vars" {
  metadata {
    name      = local.keycloak_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "KC_HOSTNAME_STRICT"              = "false"
    "KEYCLOAK_EXTRA_ARGS"             = "--import-realm"
    "QUARKUS_HTTP_ACCESS_LOG_ENABLED" = "true" // for easier debugging, can just as well be deleted
    "KEYCLOAK_HTTPS_ENABLED" = "false"
    "KC_HTTP_PORT" = "8080"
  }
}

resource "kubernetes_config_map" "keycloack_ecs_env_vars" {
    metadata {
        name      = local.keycloak_ecs_env_vars_configmap
        namespace = local.namespace
    }

    data = {
      "SERVICE_NAME"            = "keycloak"
      "APP_PORT"                = 8080
      "ASPNETCORE_HTTP_PORTS"   = local.experiment_config_sidecar_port
    }
}

resource "kubernetes_config_map" "minio_env_vars" {
  metadata {
    name      = local.minio_env_vars_configmap
    namespace = local.namespace
  }

  data = {}
}

resource "kubernetes_config_map" "misarch_address_env_vars" {
  metadata {
    name      = local.misarch_address_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SPRING_R2DBC_URL"      = "r2dbc:postgresql://${local.address_db_url}/${var.MISARCH_DB_DATABASE}"
    "SPRING_FLYWAY_URL"     = "jdbc:postgresql://${local.address_db_url}/${var.MISARCH_DB_DATABASE}"
    "SPRING_R2DBC_USERNAME" = var.MISARCH_DB_USER
    "SPRING_R2DBC_PASSWORD" = random_password.misarch_address_db_password.result
    "OTEL_EXPORTER_OTLP_ENDPOINT" = "http://${local.otel_collector_url_http}"
  }
}

resource "kubernetes_config_map" "misarch_address_ecs_env_vars" {
  metadata {
    name      = local.misarch_address_ecs_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SERVICE_NAME"            = "address"
    "ASPNETCORE_HTTP_PORTS"   = local.experiment_config_sidecar_port
  }
}

resource "kubernetes_config_map" "misarch_catalog_env_vars" {
  metadata {
    name      = local.misarch_catalog_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SPRING_R2DBC_URL"      = "r2dbc:postgresql://${local.catalog_db_url}/${var.MISARCH_DB_DATABASE}"
    "SPRING_FLYWAY_URL"     = "jdbc:postgresql://${local.catalog_db_url}/${var.MISARCH_DB_DATABASE}"
    "SPRING_R2DBC_USERNAME" = var.MISARCH_DB_USER
    "SPRING_R2DBC_PASSWORD" = random_password.misarch_catalog_db_password.result
    "OTEL_EXPORTER_OTLP_ENDPOINT" = "http://${local.otel_collector_url_http}"
  }
}

resource "kubernetes_config_map" "misarch_catalog_ecs_env_vars" {
  metadata {
    name      = local.misarch_catalog_ecs_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SERVICE_NAME"            = "catalog"
    "ASPNETCORE_HTTP_PORTS"   = local.experiment_config_sidecar_port
  }
}


resource "kubernetes_config_map" "misarch_discount_env_vars" {
  metadata {
    name      = local.misarch_discount_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SPRING_R2DBC_URL"      = "r2dbc:postgresql://${local.discount_db_url}/${var.MISARCH_DB_DATABASE}"
    "SPRING_FLYWAY_URL"     = "jdbc:postgresql://${local.discount_db_url}/${var.MISARCH_DB_DATABASE}"
    "SPRING_R2DBC_USERNAME" = var.MISARCH_DB_USER
    "SPRING_R2DBC_PASSWORD" = random_password.misarch_discount_db_password.result
    "OTEL_EXPORTER_OTLP_ENDPOINT" = "http://${local.otel_collector_url_http}"
  }
}

resource "kubernetes_config_map" "misarch_discount_ecs_env_vars" {
  metadata {
    name      = local.misarch_discount_ecs_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SERVICE_NAME"            = "discount"
    "ASPNETCORE_HTTP_PORTS"   = local.experiment_config_sidecar_port
  }
}


resource "kubernetes_config_map" "misarch_experiment_config_env_vars" {
  metadata {
    name      = local.misarch_experiment_config_env_vars_configmap
    namespace = local.namespace
  }

  data = {}
}

resource "kubernetes_config_map" "misarch_frontend_env_vars" {
  metadata {
    name      = local.misarch_frontend_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "GATEWAY_ENDPOINT"  = local.dapr_misarch_gateway_url
    "KEYCLOAK_ENDPOINT" = "http://${local.keycloak_url}/keycloak"
    "MINIO_ENDPOINT"   = local.minio_url
  }
}

resource "kubernetes_config_map" "misarch_frontend_ecs_env_vars" {
  metadata {
    name      = local.misarch_frontend_ecs_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SERVICE_NAME"            = "frontend"
    "APP_PORT"                = 80
    "ASPNETCORE_HTTP_PORTS"   = local.experiment_config_sidecar_port
  }
}

resource "kubernetes_config_map" "misarch_gateway_env_vars" {
  metadata {
    name      = local.misarch_gateway_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "NODE_ENV" = "production"
    "OTEL_EXPORTER_OTLP_ENDPOINT" = "http://${local.otel_collector_url_http}"
  }
}

resource "kubernetes_config_map" "misarch_gateway_ecs_env_vars" {
  metadata {
    name      = local.misarch_gateway_ecs_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SERVICE_NAME"            = "gateway"
    "ASPNETCORE_HTTP_PORTS"   = local.experiment_config_sidecar_port
  }
}

resource "kubernetes_config_map" "misarch_inventory_env_vars" {
  metadata {
    name      = local.misarch_inventory_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "DATABASE_URI" = "mongodb://${local.inventory_db_url}"
    "OTEL_EXPORTER_OTLP_ENDPOINT" = "http://${local.otel_collector_url_http}"
  }
}

resource "kubernetes_config_map" "misarch_inventory_ecs_env_vars" {
  metadata {
    name      = local.misarch_inventory_ecs_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SERVICE_NAME"            = "inventory"
    "ASPNETCORE_HTTP_PORTS"   = local.experiment_config_sidecar_port
  }
}

resource "kubernetes_config_map" "misarch_invoice_env_vars" {
  metadata {
    name      = local.misarch_invoice_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "ME_CONFIG_MONGODB_URL" = "mongodb://${local.invoice_db_url}"
    "MONGODB_URI" = "mongodb://${local.invoice_db_url}"
    "OTEL_EXPORTER_OTLP_ENDPOINT" = "http://${local.otel_collector_url_http}"
  }
}

resource "kubernetes_config_map" "misarch_invoice_ecs_env_vars" {
  metadata {
    name      = local.misarch_invoice_ecs_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SERVICE_NAME"            = "invoice"
    "ASPNETCORE_HTTP_PORTS"   = local.experiment_config_sidecar_port
  }
}

resource "kubernetes_config_map" "misarch_media_env_vars" {
  metadata {
    name      = local.misarch_media_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    MINIO_ENDPOINT = "http://${local.minio_url}"
    MONGODB_URI = "mongodb://${local.media_db_url}"
    "OTEL_EXPORTER_OTLP_ENDPOINT" = "http://${local.otel_collector_url_http}"
  }
}

resource "kubernetes_config_map" "misarch_media_ecs_env_vars" {
  metadata {
    name      = local.misarch_media_ecs_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SERVICE_NAME"            = "media"
    "ASPNETCORE_HTTP_PORTS"   = local.experiment_config_sidecar_port
  }
}

resource "kubernetes_config_map" "misarch_notification_env_vars" {
  metadata {
    name      = local.misarch_notification_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SPRING_R2DBC_URL"      = "r2dbc:postgresql://${local.notification_db_url}/${var.MISARCH_DB_DATABASE}"
    "SPRING_FLYWAY_URL"     = "jdbc:postgresql://${local.notification_db_url}/${var.MISARCH_DB_DATABASE}"
    "SPRING_R2DBC_USERNAME" = var.MISARCH_DB_USER
    "SPRING_R2DBC_PASSWORD" = random_password.misarch_notification_db_password.result
    "OTEL_EXPORTER_OTLP_ENDPOINT" = "http://${local.otel_collector_url_http}"
  }
}

resource "kubernetes_config_map" "misarch_notification_ecs_env_vars" {
  metadata {
    name      = local.misarch_notification_ecs_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SERVICE_NAME"            = "notification"
    "ASPNETCORE_HTTP_PORTS"   = local.experiment_config_sidecar_port
  }
}

resource "kubernetes_config_map" "misarch_order_env_vars" {
  metadata {
    name      = local.misarch_order_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "ME_CONFIG_MONGODB_URL" = "mongodb://${local.order_db_url}"
    "MONGODB_URI" = "mongodb://${local.order_db_url}"
    "OTEL_EXPORTER_OTLP_ENDPOINT" = "http://${local.otel_collector_url_http}"
  }
}

resource "kubernetes_config_map" "misarch_order_ecs_env_vars" {
  metadata {
    name      = local.misarch_order_ecs_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SERVICE_NAME"            = "order"
    "ASPNETCORE_HTTP_PORTS"   = local.experiment_config_sidecar_port
  }
}

resource "kubernetes_config_map" "misarch_payment_env_vars" {
  metadata {
    name      = local.misarch_payment_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "DATABASE_URI" = "mongodb://${local.payment_db_url}"
    "DATABASE_NAME" = var.MISARCH_DB_DATABASE
    "PAYMENT_PROVIDER_URL" = "http://${local.simulation_url}/payment/register"
    "OTEL_EXPORTER_OTLP_ENDPOINT" = "http://${local.otel_collector_url_http}"
  }
}

resource "kubernetes_config_map" "misarch_payment_ecs_env_vars" {
  metadata {
    name      = local.misarch_payment_ecs_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SERVICE_NAME"            = "payment"
    "ASPNETCORE_HTTP_PORTS"   = local.experiment_config_sidecar_port
  }
}

resource "kubernetes_config_map" "misarch_review_env_vars" {
  metadata {
    name      = local.misarch_review_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "ME_CONFIG_MONGODB_URL" = "mongodb://${local.review_db_url}"
    "MONGODB_URI" = "mongodb://${local.review_db_url}"
    "OTEL_EXPORTER_OTLP_ENDPOINT" = "http://${local.otel_collector_url_http}"
  }
}

resource "kubernetes_config_map" "misarch_review_ecs_env_vars" {
  metadata {
    name      = local.misarch_review_ecs_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SERVICE_NAME"            = "review"
    "ASPNETCORE_HTTP_PORTS"   = local.experiment_config_sidecar_port
  }
}

resource "kubernetes_config_map" "misarch_return_env_vars" {
  metadata {
    name      = local.misarch_return_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SPRING_R2DBC_URL"      = "r2dbc:postgresql://${local.return_db_url}/${var.MISARCH_DB_DATABASE}"
    "SPRING_FLYWAY_URL"     = "jdbc:postgresql://${local.return_db_url}/${var.MISARCH_DB_DATABASE}"
    "SPRING_R2DBC_USERNAME" = var.MISARCH_DB_USER
    "SPRING_R2DBC_PASSWORD" = random_password.misarch_return_db_password.result
    "OTEL_EXPORTER_OTLP_ENDPOINT" = "http://${local.otel_collector_url_http}"
  }
}

resource "kubernetes_config_map" "misarch_return_ecs_env_vars" {
  metadata {
    name      = local.misarch_return_ecs_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SERVICE_NAME"            = "return"
    "ASPNETCORE_HTTP_PORTS"   = local.experiment_config_sidecar_port
  }
}

resource "kubernetes_config_map" "misarch_shipment_env_vars" {
  metadata {
    name      = local.misarch_shipment_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SPRING_R2DBC_URL"                   = "r2dbc:postgresql://${local.shipment_db_url}/${var.MISARCH_DB_DATABASE}"
    "SPRING_FLYWAY_URL"                  = "jdbc:postgresql://${local.shipment_db_url}/${var.MISARCH_DB_DATABASE}"
    "SPRING_R2DBC_USERNAME"              = var.MISARCH_DB_USER
    "SPRING_R2DBC_PASSWORD"              = random_password.misarch_shipment_db_password.result
    "MISARCH_SHIPMENT_PROVIDER_ENDPOINT" = "http://${local.simulation_url}/shipment/register"
    "OTEL_EXPORTER_OTLP_ENDPOINT"        = "http://${local.otel_collector_url_http}"
  }
}

resource "kubernetes_config_map" "misarch_shipment_ecs_env_vars" {
  metadata {
    name      = local.misarch_shipment_ecs_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SERVICE_NAME"            = "shipment"
    "ASPNETCORE_HTTP_PORTS"   = local.experiment_config_sidecar_port
  }
}

resource "kubernetes_config_map" "misarch_shoppingcart_env_vars" {
  metadata {
    name      = local.misarch_shoppingcart_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "ME_CONFIG_MONGODB_URL" = "mongodb://${local.shoppingcart_db_url}"
    "MONGODB_URI" = "mongodb://${local.shoppingcart_db_url}"
    "OTEL_EXPORTER_OTLP_ENDPOINT" = "http://${local.otel_collector_url_http}"
  }
}

resource "kubernetes_config_map" "misarch_shoppincart_ecs_env_vars" {
  metadata {
    name      = local.misarch_shoppingcart_ecs_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SERVICE_NAME"            = "shoppingcart"
    "ASPNETCORE_HTTP_PORTS"   = local.experiment_config_sidecar_port
  }
}

resource "kubernetes_config_map" "misarch_simulation_env_vars" {
  metadata {
    name      = local.misarch_simulation_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    RABBITMQ_URL = "amqp://${local.rabbitmq_url}"
    PAYMENTS_PER_MINUTE = var.MISARCH_SIMULATION_PAYMENTS_PER_MINUTE
    SHIPMENTS_PER_MINUTE = var.MISARCH_SIMULATION_SHIPMENTS_PER_MINUTE
    PROCESSING_TIME_SECONDS = var.MISARCH_SIMULATION_PROCESSING_TIME_SECONDS
    PAYMENT_URL = "http://${local.payment_url}"
    SHIPMENT_URL = "http://${local.shipment_url}"
    OTEL_EXPORTER_OTLP_ENDPOINT = "http://${local.otel_collector_url_http}"
  }
}

resource "kubernetes_config_map" "misarch_simulation_ecs_env_vars" {
  metadata {
    name      = local.misarch_simulation_ecs_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SERVICE_NAME"            = "simulation"
    "ASPNETCORE_HTTP_PORTS"   = local.experiment_config_sidecar_port
  }
}

resource "kubernetes_config_map" "misarch_tax_env_vars" {
  metadata {
    name      = local.misarch_tax_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SPRING_R2DBC_URL"      = "r2dbc:postgresql://${local.tax_db_url}/${var.MISARCH_DB_DATABASE}"
    "SPRING_FLYWAY_URL"     = "jdbc:postgresql://${local.tax_db_url}/${var.MISARCH_DB_DATABASE}"
    "SPRING_R2DBC_USERNAME" = var.MISARCH_DB_USER
    "SPRING_R2DBC_PASSWORD" = random_password.misarch_tax_db_password.result
    "OTEL_EXPORTER_OTLP_ENDPOINT" = "http://${local.otel_collector_url_http}"
  }
}

resource "kubernetes_config_map" "misarch_tax_ecs_env_vars" {
  metadata {
    name      = local.misarch_tax_ecs_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SERVICE_NAME"            = "tax"
    "ASPNETCORE_HTTP_PORTS"   = local.experiment_config_sidecar_port
  }
}

# resource "kubernetes_config_map" "misarch_testdata_env_vars" {
#   metadata {
#     name      = local.misarch_testdata_env_vars_configmap
#     namespace = local.namespace
#   }
#
#   data = {
#     GRAPHQL_ENDPOINT = "http://misarch-gateway:8080/graphql"
#     KEYCLOAK_URL = "http://${local.keycloak_url}/keycloak"
#     REALM = "Misarch"
#     ADMIN_USER = "admin"
#     ADMIN_PASS = "admin"
#     ADMIN_CLIENT_ID = "admin-cli"
#     CLIENT_ID = "frontend"
#     GATLING_USERNAME = "gatling"
#     GATLING_PASSWORD = "123"
#     GRANT_TYPE = "password"
#   }
# }

resource "kubernetes_config_map" "misarch_user_env_vars" {
  metadata {
    name      = local.misarch_user_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SPRING_R2DBC_URL"      = "r2dbc:postgresql://${local.user_db_url}/${var.MISARCH_DB_DATABASE}"
    "SPRING_FLYWAY_URL"     = "jdbc:postgresql://${local.user_db_url}/${var.MISARCH_DB_DATABASE}"
    "SPRING_R2DBC_USERNAME" = var.MISARCH_DB_USER
    "SPRING_R2DBC_PASSWORD" = random_password.misarch_user_db_password.result
    "OTEL_EXPORTER_OTLP_ENDPOINT" = "http://${local.otel_collector_url_http}"
  }
}

resource "kubernetes_config_map" "misarch_user_ecs_env_vars" {
  metadata {
    name      = local.misarch_user_ecs_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SERVICE_NAME"            = "user"
    "ASPNETCORE_HTTP_PORTS"   = local.experiment_config_sidecar_port
  }
}

resource "kubernetes_config_map" "misarch_wishlist_env_vars" {
  metadata {
    name      = local.misarch_wishlist_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "ME_CONFIG_MONGODB_URL" = "mongodb://${local.wishlist_db_url}"
    "MONGODB_URI" = "mongodb://${local.wishlist_db_url}"
    "OTEL_EXPORTER_OTLP_ENDPOINT" = "http://${local.otel_collector_url_http}"
  }
}

resource "kubernetes_config_map" "misarch_wishlist_ecs_env_vars" {
  metadata {
    name      = local.misarch_wishlist_ecs_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SERVICE_NAME"            = "wishlist"
    "ASPNETCORE_HTTP_PORTS"   = local.experiment_config_sidecar_port
  }
}

resource "kubernetes_config_map" "rabbitmq_env_vars" {
  metadata {
    name      = local.rabbitmq_env_vars_configmap
    namespace = local.namespace
  }

  data = {}
}
