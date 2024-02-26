variable "ROOT_DOMAIN" {
  type        = string
  description = "Full URL the instance will be published on. Should not have a trailing slash."
}

variable "MISARCH_CATALOG_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "KEYCLOAK_VERSION" {
  type    = string
  default = "23.0"
}

variable "KEYCLOAK_ADMIN_PASSWORD" {
  sensitive = true
  type      = string
  default   = "admin"
}

variable "KEYCLOAK_USER_EVENTS_PLUGIN_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "MISARCH_REVIEW_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "MISARCH_WISHLIST_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "MISARCH_SHOPPINGCART_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "MISARCH_INVENTORY_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "MISARCH_MEDIA_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "MISARCH_TAX_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "MISARCH_DISCOUNT_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "MISARCH_USER_VERSION" {
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

variable "MISARCH_ADDRESS_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "MISARCH_RETURN_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "MISARCH_INVOICE_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "MISARCH_SHIPMENT_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "MISARCH_PAYMENT_VERSION" {
  type    = string
  default = "v0.0.1"
}

variable "BASE_MISARCH_ANNOTATIONS" {
  type        = map
  description = "K8s annotations applied to any Misarch deployment"
  default     = {
    "dapr.io/enabled"   = true
    "dapr.io/http-port" = 3500
    "dapr.io/config"    = "/config.yaml",
  }
}

variable "KUBERNETES_CONFIG_PATH" {
  sensitive = true
  type      = string
}

variable "KUBERNETES_NAMESPACE" {
  type    = string
  default = "misarch"
}
