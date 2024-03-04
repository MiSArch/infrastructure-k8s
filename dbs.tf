resource "helm_release" "misarch_catalog_db" {
  name       = local.catalog_db_service_name
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "postgresql"
  namespace  = local.namespace

  values = [
    <<-EOF
    fullnameOverride: "${local.catalog_db_service_name}"
    image:
      tag: "${var.POSTGRES_VERSION}"
    auth:
      enablePostgresUser: false
      username: "${var.MISARCH_DB_USER}"
      database: "${var.MISARCH_DB_DATABASE}"
      password: "${random_password.misarch_catalog_db_password.result}"
    metrics:
      enabled: true
    EOF
  ]
}
