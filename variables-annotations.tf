locals {
  base_misarch_annotations = {
    "dapr.io/enabled"               = "true"
    "dapr.io/http-port"             = "3500"
    "dapr.io/config"                = "${local.dapr_general_config_name}"
    "dapr.io/log-level"             = "debug"
    "dapr.io/http-read-buffer-size" = "20" # KB, apparently the default of 4KB is too small in our usecase

    "dapr.io/sidecar-liveness-probe-threshold"      = "10"
    "dapr.io/sidecar-liveness-probe-delay-seconds"  = "10"
    "dapr.io/sidecar-readiness-probe-threshold"     = "10"
    "dapr.io/sidecar-readiness-probe-delay-seconds" = "10"
  }
}

locals {
  misarch_ingress_annotations = {
    "kubernetes.io/ingress.class"                   = "nginx"
    "nginx.ingress.kubernetes.io/proxy-body-size"   = "10m"
    "nginx.ingress.kubernetes.io/proxy-buffer-size" = "10m"
  }
  keycloak_specific_annotations = {
    "dapr.io/app-id"   = "keycloak"
    "dapr.io/app-port" = local.experiment_config_sidecar_port
  }
  minio_specific_annotations = {
    "dapr.io/app-id"  = "minio"
    "dapr.io/app-port" = local.minio_port
    "prometheus.io/scrape": "true"
    "prometheus.io/path": "/minio/v2/metrics/cluster"
    "prometheus.io/port": local.minio_port
  }
  misarch_address_specific_annotations = {
    "dapr.io/app-id"   = "address"
    "dapr.io/app-port" = local.experiment_config_sidecar_port
  }
  misarch_catalog_specific_annotations = {
    "dapr.io/app-id"   = "catalog"
    "dapr.io/app-port" = local.experiment_config_sidecar_port
  }
  misarch_discount_specific_annotations = {
    "dapr.io/app-id"   = "discount"
    "dapr.io/app-port" = local.experiment_config_sidecar_port
  }
  misarch_experiment_config_specific_annotations = {
    "dapr.io/app-id"   = "experiment-config"
    "dapr.io/app-port" = "8080"
  }
  misarch_frontend_specific_annotations = {
    "dapr.io/app-id"   = "frontend"
    "dapr.io/app-port" = local.experiment_config_sidecar_port
  }
  misarch_gateway_specific_annotations = {
    "dapr.io/app-id"   = "gateway"
    "dapr.io/app-port" = local.experiment_config_sidecar_port
  }
  misarch_inventory_specific_annotations = {
    "dapr.io/app-id"   = "inventory"
    "dapr.io/app-port" = local.experiment_config_sidecar_port
  }
  misarch_invoice_specific_annotations = {
    "dapr.io/app-id"   = "invoice"
    "dapr.io/app-port" = local.experiment_config_sidecar_port
  }
  misarch_media_specific_annotations = {
    "dapr.io/app-id"   = "media"
    "dapr.io/app-port" = local.experiment_config_sidecar_port
  }
  misarch_notification_specific_annotations = {
    "dapr.io/app-id"   = "notification"
    "dapr.io/app-port" = local.experiment_config_sidecar_port
  }
  misarch_order_specific_annotations = {
    "dapr.io/app-id"   = "order"
    "dapr.io/app-port" = local.experiment_config_sidecar_port
  }
  misarch_payment_specific_annotations = {
    "dapr.io/app-id"   = "payment"
    "dapr.io/app-port" = local.experiment_config_sidecar_port
  }
  misarch_review_specific_annotations = {
    "dapr.io/app-id"   = "review"
    "dapr.io/app-port" = local.experiment_config_sidecar_port
  }
  misarch_return_specific_annotations = {
    "dapr.io/app-id"   = "return"
    "dapr.io/app-port" = local.experiment_config_sidecar_port
  }
  misarch_shipment_specific_annotations = {
    "dapr.io/app-id"   = "shipment"
    "dapr.io/app-port" = local.experiment_config_sidecar_port
  }
  misarch_shoppingcart_specific_annotations = {
    "dapr.io/app-id"   = "shoppingcart"
    "dapr.io/app-port" = local.experiment_config_sidecar_port
  }
  misarch_simulation_specific_annotations = {
    "dapr.io/app-id"   = "simulation"
    "dapr.io/app-port" = local.experiment_config_sidecar_port
  }
  misarch_tax_specific_annotations = {
    "dapr.io/app-id"   = "tax"
    "dapr.io/app-port" = local.experiment_config_sidecar_port
  }
  misarch_user_specific_annotations = {
    "dapr.io/app-id"   = "user"
    "dapr.io/app-port" = local.experiment_config_sidecar_port
  }
  misarch_wishlist_specific_annotations = {
    "dapr.io/app-id"   = "wishlist"
    "dapr.io/app-port" = local.experiment_config_sidecar_port
  }
  rabbitmq_specific_annotations = {
    "dapr.io/enabled" = "false"
  }
}
