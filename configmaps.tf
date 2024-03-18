locals {
  misarch_base_env_vars_configmap = "misarch-base-env-vars"

  keycloak_env_vars_configmap             = "keycloak-custom-env-vars"
  misarch_address_env_vars_configmap      = "misarch-address-env-vars"
  misarch_catalog_env_vars_configmap      = "misarch-catalog-env-vars"
  misarch_discount_env_vars_configmap     = "misarch-discount-env-vars"
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
  misarch_tax_env_vars_configmap          = "misarch-tax-env-vars"
  misarch_user_env_vars_configmap         = "misarch-user-env-vars"
  misarch_wishlist_env_vars_configmap     = "misarch-wishlist-env-vars"
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
    "KC_HOSTNAME_STRICT"  = "false"
    "KEYCLOAK_EXTRA_ARGS" = "--import-realm"
  }
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
  }
}

resource "kubernetes_config_map" "misarch_frontend_env_vars" {
  metadata {
    name      = local.misarch_frontend_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "GATEWAY_ENDPOINT" = local.dapr_misarch_gateway_url
    "KEYCLOAK_ENDPOINT" = local.keycloak_url
  }
}

resource "kubernetes_config_map" "misarch_gateway_env_vars" {
  metadata {
    name      = local.misarch_gateway_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "NODE_ENV" = "production"
  }
}

resource "kubernetes_config_map" "misarch_inventory_env_vars" {
  metadata {
    name      = local.misarch_inventory_env_vars_configmap
    namespace = local.namespace
  }

  data = {}
}

resource "kubernetes_config_map" "misarch_invoice_env_vars" {
  metadata {
    name      = local.misarch_invoice_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SPRING_R2DBC_URL"      = "r2dbc:postgresql://${local.invoice_db_url}/${var.MISARCH_DB_DATABASE}"
    "SPRING_FLYWAY_URL"     = "jdbc:postgresql://${local.invoice_db_url}/${var.MISARCH_DB_DATABASE}"
    "SPRING_R2DBC_USERNAME" = var.MISARCH_DB_USER
    "SPRING_R2DBC_PASSWORD" = random_password.misarch_invoice_db_password.result
  }
}

resource "kubernetes_config_map" "misarch_media_env_vars" {
  metadata {
    name      = local.misarch_media_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SPRING_R2DBC_URL"      = "r2dbc:postgresql://${local.media_db_url}/${var.MISARCH_DB_DATABASE}"
    "SPRING_FLYWAY_URL"     = "jdbc:postgresql://${local.media_db_url}/${var.MISARCH_DB_DATABASE}"
    "SPRING_R2DBC_USERNAME" = var.MISARCH_DB_USER
    "SPRING_R2DBC_PASSWORD" = random_password.misarch_media_db_password.result
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
  }
}

resource "kubernetes_config_map" "misarch_order_env_vars" {
  metadata {
    name      = local.misarch_order_env_vars_configmap
    namespace = local.namespace
  }

  data = {}
}

resource "kubernetes_config_map" "misarch_payment_env_vars" {
  metadata {
    name      = local.misarch_payment_env_vars_configmap
    namespace = local.namespace
  }

  data = {}
}

resource "kubernetes_config_map" "misarch_review_env_vars" {
  metadata {
    name      = local.misarch_review_env_vars_configmap
    namespace = local.namespace
  }

  data = {}
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
  }
}

resource "kubernetes_config_map" "misarch_shipment_env_vars" {
  metadata {
    name      = local.misarch_shipment_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SPRING_R2DBC_URL"      = "r2dbc:postgresql://${local.shipment_db_url}/${var.MISARCH_DB_DATABASE}"
    "SPRING_FLYWAY_URL"     = "jdbc:postgresql://${local.shipment_db_url}/${var.MISARCH_DB_DATABASE}"
    "SPRING_R2DBC_USERNAME" = var.MISARCH_DB_USER
    "SPRING_R2DBC_PASSWORD" = random_password.misarch_shipment_db_password.result
    "MISARCH_SHIPMENT_PROVIDER_ENDPOINT" = "http://localhost/does-not-exist" # To who is responsible for creating the simulation service: We are waiting for the full service!
  }
}

resource "kubernetes_config_map" "misarch_shoppingcart_env_vars" {
  metadata {
    name      = local.misarch_shoppingcart_env_vars_configmap
    namespace = local.namespace
  }

  data = {}
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
  }
}

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
  }
}

resource "kubernetes_config_map" "misarch_wishlist_env_vars" {
  metadata {
    name      = local.misarch_wishlist_env_vars_configmap
    namespace = local.namespace
  }

  data = {}
}

