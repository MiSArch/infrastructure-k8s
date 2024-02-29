resource "helm_release" "misarch_catalog_db" {
  name       = "catalog-db"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "postgresql-ha"
  namespace  = local.namespace
  version    = "13.4.5" # Why do we need to specify the version? For some reason, otherwise it tries the latest version of non-ha

  values = [
    <<-EOF
    fullnameOverride: "${local.catalog_db_service_name}"
    image:
      tag: "${var.POSTGRES_VERSION}"
    postgresql:
      username: "${var.MISARCH_DB_USER}"
      database: "${var.MISARCH_DB_DATABASE}"
      password: "${random_password.misarch_catalog_db_password.result}"
      postgresPassword: "${random_password.misarch_catalog_db_postgres_user_password.result}"
      repmgrPassword: "${random_password.misarch_catalog_db_repmgr_password.result}"
      configuration: |-
        log_connections = 'on'
        log_min_messages = 'DEBUG5'
    pgpool:
      adminPassword: "${random_password.misarch_catalog_db_pgpool_password.result}"
    metrics:
      enabled: true
    EOF
  ]
}
