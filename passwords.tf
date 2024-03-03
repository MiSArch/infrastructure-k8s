resource "random_password" "redis" {
  length  = 32
  special = false
}

resource "random_password" "keycloak_db_password" {
  length  = 32
  special = false
}

resource "random_password" "misarch_catalog_db_password" {
  length  = 32
  special = false
}
