locals {
  misarch_base_env_vars_configmap = "misarch-base-env-vars"

  misarch_catalog_env_vars_configmap = "misarch-catalog-env-vars"
}

resource "kubernetes_config_map" "base_misarch_env_vars" {
  metadata {
    name      = local.misarch_base_env_vars_configmap
    namespace = local.namespace
  }
}

resource "kubernetes_config_map" "misarch_catalog_env_vars" {
  metadata {
    name      = local.misarch_catalog_env_vars_configmap
    namespace = local.namespace
  }

  data = {
    "SPRING_R2DBC_URL"      = "r2dbc:postgresql://${local.catalog_db_url}/${var.MISARCH_DB_DATABASE}"
    "SPRING_FLYWAY_URL"     = "jdbc:postgresql://${local.catalog_db_url}/${var.MISARCH_DB_DATABASE}"
    "SPRING_R2DBC_USERNAME" = var.MISARCH_DB_USER
    "SPRING_R2DBC_PASSWORD" = random_password.misarch_catalog_db_password.result
  }
}
