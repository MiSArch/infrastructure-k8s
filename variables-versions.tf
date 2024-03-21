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

variable "KEYCLOAK_USER_EVENTS_PLUGIN_VERSION" {
  type    = string
  default = "v0.0.4"
}

variable "MISARCH_ADDRESS_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "MISARCH_CATALOG_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "MISARCH_DISCOUNT_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "MISARCH_FRONTEND_VERSION" {
  type    = string
  default = "v0.0.2"
}

variable "MISARCH_GATEWAY_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "MISARCH_INVENTORY_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "MISARCH_INVOICE_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "MISARCH_MEDIA_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "MISARCH_NOTIFICATION_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "MISARCH_ORDER_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "MISARCH_PAYMENT_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "MISARCH_RETURN_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "MISARCH_REVIEW_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "MISARCH_SHIPMENT_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "MISARCH_SHOPPINGCART_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "MISARCH_TAX_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "MISARCH_USER_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "MISARCH_WISHLIST_VERSION" {
  type    = string
  default = "v0.0.1"
}
