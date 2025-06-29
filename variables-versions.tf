variable "MONGODB_VERSION" {
  type    = string
  default = "7.0.15"
}

variable "POSTGRES_VERSION" {
  type    = string
  default = "16"
}

variable "KEYCLOAK_VERSION" {
  type    = string
  default = "23"
}

variable "KEYCLOAK_ADMIN_PASSWORD" {
  sensitive = true
  type      = string
  default   = "admin"
}

variable "MISARCH_KEYCLOAK_VERSION" {
  type    = string
  default = "main"
}

variable "KEYCLOAK_USER_EVENTS_PLUGIN_VERSION" {
  type    = string
  default = "main"
}

variable "MINIO_VERSION" {
  type = string
  default = "2024.5.10"
}

variable "RABBITMQ_VERSION" {
  type = string
  default = "3.13.2"
}

variable "MISARCH_ADDRESS_VERSION" {
  type    = string
  default = "main"
}

variable "MISARCH_CATALOG_VERSION" {
  type    = string
  default = "main"
}

variable "MISARCH_DISCOUNT_VERSION" {
  type    = string
  default = "main"
}

variable "MISARCH_EXPERIMENT_CONFIG_VERSION" {
  type    = string
  default = "main"
}

variable "MISARCH_FRONTEND_VERSION" {
  type    = string
  default = "main"
}

variable "MISARCH_GATEWAY_VERSION" {
  type    = string
  default = "main"
}

variable "MISARCH_INVENTORY_VERSION" {
  type    = string
  default = "main"
}

variable "MISARCH_INVOICE_VERSION" {
  type    = string
  default = "main"
}

variable "MISARCH_MEDIA_VERSION" {
  type    = string
  default = "main"
}

variable "MISARCH_NOTIFICATION_VERSION" {
  type    = string
  default = "main"
}

variable "MISARCH_ORDER_VERSION" {
  type    = string
  default = "main"
}

variable "MISARCH_PAYMENT_VERSION" {
  type    = string
  default = "main"
}

variable "MISARCH_RETURN_VERSION" {
  type    = string
  default = "main"
}

variable "MISARCH_REVIEW_VERSION" {
  type    = string
  default = "main"
}

variable "MISARCH_SHIPMENT_VERSION" {
  type    = string
  default = "main"
}

variable "MISARCH_SHOPPINGCART_VERSION" {
  type    = string
  default = "main"
}

variable "MISARCH_SIMULATION_VERSION" {
  type    = string
  default = "main"
}

variable "MISARCH_TAX_VERSION" {
  type    = string
  default = "main"
}

#variable "MISARCH_TESTDATA_VERSION" {
#  type = string
#  default = "main"
#}

variable "MISARCH_USER_VERSION" {
  type    = string
  default = "main"
}

variable "MISARCH_WISHLIST_VERSION" {
  type    = string
  default = "main"
}

variable "MISARCH_EXPERIMENT_CONFIG_SIDECAR_VERSION" {
  type    = string
  default = "main"
}

variable "OTEL_COLLECTOR_VERSION" {
  type    = string
  default = "0.128.0"
}