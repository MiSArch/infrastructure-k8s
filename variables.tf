/*
# Uncomment if there are any private images
variable "IMAGE_PULL_SECRET" {
  sensitive = true
  type      = string
}
*/

variable "ROOT_DOMAIN" {
  type        = string
  description = "Full URL the instance will be published on. Should not have a trailing slash."
}

variable "CATALOG_VERSION" {
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

variable "KUBERNETES_CONFIG_PATH" {
  sensitive = true
  type      = string
}

variable "KUBERNETES_NAMESPACE" {
  type    = string
  default = "misarch"
}
