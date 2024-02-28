variable "ROOT_DOMAIN" {
  type        = string
  description = "Full URL the instance will be published on. Should not have a trailing slash."
}

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

  db_port = 5432
}

locals {
  address_db_url      = "${local.address_db_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.db_port}"
  catalog_db_url      = "${local.catalog_db_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.db_port}"
  discount_db_url     = "${local.discount_db_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.db_port}"
  inventory_db_url    = "${local.inventory_db_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.db_port}"
  invoice_db_url      = "${local.invoice_db_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.db_port}"
  media_db_url        = "${local.media_db_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.db_port}"
  notification_db_url = "${local.notification_db_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.db_port}"
  order_db_url        = "${local.order_db_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.db_port}"
  payment_db_url      = "${local.payment_db_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.db_port}"
  review_db_url       = "${local.review_db_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.db_port}"
  return_db_url       = "${local.return_db_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.db_port}"
  shipment_db_url     = "${local.shipment_db_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.db_port}"
  shoppingcart_db_url = "${local.shoppingcart_db_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.db_port}"
  tax_db_url          = "${local.tax_db_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.db_port}"
  user_db_url         = "${local.user_db_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.db_port}"
  wishlist_db_url     = "${local.wishlist_db_service_name}.${var.KUBERNETES_NAMESPACE}.svc.cluster.local:${local.db_port}"
}
