/*
# Uncomment if there are any private images
variable "image_pull_secret" {
  sensitive = true
  type      = string
}
*/

variable "root_domain" {
  type        = string
  description = "Full URL the instance will be published on. Should not have a trailing slash."
}

variable "catalog_version" {
  type    = string
  default = "v0.0.1"
}

variable "keycloak_version" {
  type    = string
  default = "v0.0.2"
}

variable "keycloak_admin_password" {
  sensitive = true
  type      = string
  default   = "admin"
}

variable "kubernetes_config_path" {
  sensitive = true
  type      = string
  default   = "./kubeconfig.yaml"
}

variable "kubernetes_namespace" {
  type    = string
  default = "misarch"
}
