locals {
  base_misarch_annotations = {
    "dapr.io/enabled"   = true
    "dapr.io/http-port" = 3500
    "dapr.io/config"    = local.dapr_general_config_name
  }
}

locals {
  misarch_address_specific_annotations = {
    "dapr.io/app-id"   = "address"
    "dapr.io/app-port" = 8080
  }
  misarch_catalog_specific_annotations = {
    "dapr.io/app-id"   = "catalog"
    "dapr.io/app-port" = 8080
  }
  misarch_discount_specific_annotations = {
    "dapr.io/app-id"   = "discount"
    "dapr.io/app-port" = 8080
  }
  misarch_inventory_specific_annotations = {
    "dapr.io/app-id"   = "inventory"
    "dapr.io/app-port" = 8080
  }
  misarch_invoice_specific_annotations = {
    "dapr.io/app-id"   = "invoice"
    "dapr.io/app-port" = 8080
  }
  misarch_media_specific_annotations = {
    "dapr.io/app-id"   = "media"
    "dapr.io/app-port" = 8080
  }
  misarch_notification_specific_annotations = {
    "dapr.io/app-id"   = "notification"
    "dapr.io/app-port" = 8080
  }
  misarch_order_specific_annotations = {
    "dapr.io/app-id"   = "order"
    "dapr.io/app-port" = 8080
  }
  misarch_payment_specific_annotations = {
    "dapr.io/app-id"   = "payment"
    "dapr.io/app-port" = 8080
  }
  misarch_review_specific_annotations = {
    "dapr.io/app-id"   = "review"
    "dapr.io/app-port" = 8080
  }
  misarch_return_specific_annotations = {
    "dapr.io/app-id"   = "return"
    "dapr.io/app-port" = 8080
  }
  misarch_shipment_specific_annotations = {
    "dapr.io/app-id"   = "shipment"
    "dapr.io/app-port" = 8080
  }
  misarch_shoppingcart_specific_annotations = {
    "dapr.io/app-id"   = "shoppingcart"
    "dapr.io/app-port" = 8080
  }
  misarch_tax_specific_annotations = {
    "dapr.io/app-id"   = "tax"
    "dapr.io/app-port" = 8080
  }
  misarch_user_specific_annotations = {
    "dapr.io/app-id"   = "user"
    "dapr.io/app-port" = 8080
  }
  misarch_wishlist_specific_annotations = {
    "dapr.io/app-id"   = "wishlist"
    "dapr.io/app-port" = 8080
  }
}
