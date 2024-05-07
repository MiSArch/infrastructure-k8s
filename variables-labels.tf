locals {
  base_misarch_labels = {}
}
locals {
  misarch_address_specific_labels = {
    app = local.misarch_address_service_name
  }
  misarch_catalog_specific_labels = {
    app = local.misarch_catalog_service_name
  }
  misarch_discount_specific_labels = {
    app = local.misarch_discount_service_name
  }
  misarch_experiment_config_specific_labels = {
    app = local.misarch_experiment_config_service_name
  }
  misarch_frontend_specific_labels = {
    app = local.misarch_frontend_service_name
  }
  misarch_gateway_specific_labels = {
    app = local.misarch_gateway_service_name
  }
  misarch_inventory_specific_labels = {
    app = local.misarch_inventory_service_name
  }
  misarch_invoice_specific_labels = {
    app = local.misarch_invoice_service_name
  }
  misarch_media_specific_labels = {
    app = local.misarch_media_service_name
  }
  misarch_notification_specific_labels = {
    app = local.misarch_notification_service_name
  }
  misarch_order_specific_labels = {
    app = local.misarch_order_service_name
  }
  misarch_payment_specific_labels = {
    app = local.misarch_payment_service_name
  }
  misarch_review_specific_labels = {
    app = local.misarch_review_service_name
  }
  misarch_return_specific_labels = {
    app = local.misarch_return_service_name
  }
  misarch_shipment_specific_labels = {
    app = local.misarch_shipment_service_name
  }
  misarch_shoppingcart_specific_labels = {
    app = local.misarch_shoppingcart_service_name
  }
  misarch_simulation_specific_labels = {
    app = local.misarch_simulation_service_name
  }
  misarch_tax_specific_labels = {
    app = local.misarch_tax_service_name
  }
  misarch_user_specific_labels = {
    app = local.misarch_user_service_name
  }
  misarch_wishlist_specific_labels = {
    app = local.misarch_wishlist_service_name
  }
}
