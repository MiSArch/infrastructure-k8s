variable "ROOT_DOMAIN" {
  type        = string
  description = "Full URL the instance will be published on. Should not have a trailing slash."
}

// DBs
locals {
  address_db_service_name      = "address-db"
  catalog_db_service_name      = "catalog-db"
  discount_db_service_name     = "discount-db"
  inventory_db_service_name    = "inventory-db"
  invoice_db_service_name      = "invoice-db"
  media_db_service_name        = "media-db"
  notification_db_service_name = "notification-db"
  order_db_service_name        = "order-db"
  payment_db_service_name      = "payment-db"
  review_db_service_name       = "review-db"
  return_db_service_name       = "return-db"
  shipment_db_service_name     = "shipment-db"
  shoppingcart_db_service_name = "shoppingcart-db"
  tax_db_service_name          = "tax-db"
  user_db_service_name         = "user-db"
  wishlist_db_service_name     = "wishlist-db"
}

// Services
locals {
  misarch_address_service_name      = "misarch-address"
  misarch_catalog_service_name      = "misarch-catalog"
  misarch_discount_service_name     = "misarch-discount"
  misarch_frontend_service_name     = "misarch-frontend"
  misarch_gateway_service_name      = "misarch-gateway"
  misarch_inventory_service_name    = "misarch-inventory"
  misarch_invoice_service_name      = "misarch-invoice"
  misarch_media_service_name        = "misarch-media"
  misarch_notification_service_name = "misarch-notification"
  misarch_order_service_name        = "misarch-order"
  misarch_payment_service_name      = "misarch-payment"
  misarch_review_service_name       = "misarch-review"
  misarch_return_service_name       = "misarch-return"
  misarch_shipment_service_name     = "misarch-shipment"
  misarch_shoppingcart_service_name = "misarch-shoppingcart"
  misarch_tax_service_name          = "misarch-tax"
  misarch_user_service_name         = "misarch-user"
  misarch_wishlist_service_name     = "misarch-wishlist"

  otel_collector_service_name = "otel-collector"
}

// Ports
locals {
  postgres_db_port    = 5432
  mongo_db_port       = 27017
  otel_collector_port = 4317
  dapr_port           = 3500
}

// DB Addresses
locals {
  // The Postgresql HA Helm chart always appends '-postgresql', so we would need to add it to the URL too, if we switched to it
  address_db_full_service_name      = local.address_db_service_name # "${local.address_db_service_name}-postgresql"
  catalog_db_full_service_name      = local.catalog_db_service_name
  discount_db_full_service_name     = local.discount_db_service_name
  inventory_db_full_service_name    = local.inventory_db_service_name
  invoice_db_full_service_name      = local.invoice_db_service_name
  media_db_full_service_name        = local.media_db_service_name
  notification_db_full_service_name = local.notification_db_service_name
  order_db_full_service_name        = local.order_db_service_name
  payment_db_full_service_name      = local.payment_db_service_name
  review_db_full_service_name       = local.review_db_service_name
  return_db_full_service_name       = local.return_db_service_name
  shipment_db_full_service_name     = local.shipment_db_service_name
  shoppingcart_db_full_service_name = local.shoppingcart_db_service_name
  tax_db_full_service_name          = local.tax_db_service_name
  user_db_full_service_name         = local.user_db_service_name
  wishlist_db_full_service_name     = local.wishlist_db_service_name

  otel_collector_full_service_name = "${local.otel_collector_service_name}-opentelemetry-collector"
}

// Full DB URLs
locals {
  address_db_url      = "${local.address_db_full_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.postgres_db_port}"
  catalog_db_url      = "${local.catalog_db_full_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.postgres_db_port}"
  discount_db_url     = "${local.discount_db_full_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.postgres_db_port}"
  inventory_db_url    = "${local.inventory_db_full_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.mongo_db_port}"
  invoice_db_url      = "${local.invoice_db_full_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.postgres_db_port}"
  media_db_url        = "${local.media_db_full_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.postgres_db_port}"
  notification_db_url = "${local.notification_db_full_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.postgres_db_port}"
  order_db_url        = "${local.order_db_full_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.mongo_db_port}"
  payment_db_url      = "${local.payment_db_full_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.mongo_db_port}"
  review_db_url       = "${local.review_db_full_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.mongo_db_port}"
  return_db_url       = "${local.return_db_full_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.postgres_db_port}"
  shipment_db_url     = "${local.shipment_db_full_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.postgres_db_port}"
  shoppingcart_db_url = "${local.shoppingcart_db_full_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.mongo_db_port}"
  tax_db_url          = "${local.tax_db_full_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.postgres_db_port}"
  user_db_url         = "${local.user_db_full_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.postgres_db_port}"
  wishlist_db_url     = "${local.wishlist_db_full_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.mongo_db_port}"

  otel_collector_url = "${local.otel_collector_full_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.otel_collector_port}"
  dapr_url           = "http://localhost:${local.dapr_port}"
}


// GraphQL URLs
locals {
  dapr_misarch_gateway_url = "${local.dapr_url}/v1.0/invoke/gateway/method/graphql"
}
