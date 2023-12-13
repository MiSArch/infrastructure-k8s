variable "image_pull_secret" {
  sensitive = true
  type      = string
}

variable "root_domain" {
  type = string
}

variable "version" {
  type    = string
  default = "latest"
}

variable "keycloak_version" {
  type    = string
  default = var.version
}

variable "keycloak_admin_password" {
  sensitive = true
  type      = string
  default   = "admin"
}
