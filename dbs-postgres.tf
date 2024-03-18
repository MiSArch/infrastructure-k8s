resource "helm_release" "misarch_address_db" {
  name       = local.address_db_service_name
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "postgresql"
  namespace  = local.namespace

  values = [
    <<-EOF
    fullnameOverride: "${local.address_db_service_name}"
    image:
      tag: "${var.POSTGRES_VERSION}"
    auth:
      enablePostgresUser: false
      username: "${var.MISARCH_DB_USER}"
      database: "${var.MISARCH_DB_DATABASE}"
      password: "${random_password.misarch_address_db_password.result}"
    metrics:
      enabled: true
    EOF
  ]
}

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
resource "helm_release" "misarch_discount_db" {
  name       = local.discount_db_service_name
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "postgresql"
  namespace  = local.namespace

  values = [
    <<-EOF
    fullnameOverride: "${local.discount_db_service_name}"
    image:
      tag: "${var.POSTGRES_VERSION}"
    auth:
      enablePostgresUser: false
      username: "${var.MISARCH_DB_USER}"
      database: "${var.MISARCH_DB_DATABASE}"
      password: "${random_password.misarch_discount_db_password.result}"
    metrics:
      enabled: true
    EOF
  ]
}

resource "helm_release" "misarch_media_db" {
  name       = local.media_db_service_name
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "postgresql"
  namespace  = local.namespace

  values = [
    <<-EOF
    fullnameOverride: "${local.media_db_service_name}"
    image:
      tag: "${var.POSTGRES_VERSION}"
    auth:
      enablePostgresUser: false
      username: "${var.MISARCH_DB_USER}"
      database: "${var.MISARCH_DB_DATABASE}"
      password: "${random_password.misarch_media_db_password.result}"
    metrics:
      enabled: true
    EOF
  ]
}

resource "helm_release" "misarch_notification_db" {
  name       = local.notification_db_service_name
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "postgresql"
  namespace  = local.namespace

  values = [
    <<-EOF
    fullnameOverride: "${local.notification_db_service_name}"
    image:
      tag: "${var.POSTGRES_VERSION}"
    auth:
      enablePostgresUser: false
      username: "${var.MISARCH_DB_USER}"
      database: "${var.MISARCH_DB_DATABASE}"
      password: "${random_password.misarch_notification_db_password.result}"
    metrics:
      enabled: true
    EOF
  ]
}

resource "helm_release" "misarch_return_db" {
  name       = local.return_db_service_name
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "postgresql"
  namespace  = local.namespace

  values = [
    <<-EOF
    fullnameOverride: "${local.return_db_service_name}"
    image:
      tag: "${var.POSTGRES_VERSION}"
    auth:
      enablePostgresUser: false
      username: "${var.MISARCH_DB_USER}"
      database: "${var.MISARCH_DB_DATABASE}"
      password: "${random_password.misarch_return_db_password.result}"
    metrics:
      enabled: true
    EOF
  ]
}

resource "helm_release" "misarch_shipment_db" {
  name       = local.shipment_db_service_name
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "postgresql"
  namespace  = local.namespace

  values = [
    <<-EOF
    fullnameOverride: "${local.shipment_db_service_name}"
    image:
      tag: "${var.POSTGRES_VERSION}"
    auth:
      enablePostgresUser: false
      username: "${var.MISARCH_DB_USER}"
      database: "${var.MISARCH_DB_DATABASE}"
      password: "${random_password.misarch_shipment_db_password.result}"
    metrics:
      enabled: true
    EOF
  ]
}

resource "helm_release" "misarch_tax_db" {
  name       = local.tax_db_service_name
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "postgresql"
  namespace  = local.namespace

  values = [
    <<-EOF
    fullnameOverride: "${local.tax_db_service_name}"
    image:
      tag: "${var.POSTGRES_VERSION}"
    auth:
      enablePostgresUser: false
      username: "${var.MISARCH_DB_USER}"
      database: "${var.MISARCH_DB_DATABASE}"
      password: "${random_password.misarch_tax_db_password.result}"
    metrics:
      enabled: true
    EOF
  ]
}

resource "helm_release" "misarch_user_db" {
  name       = local.user_db_service_name
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "postgresql"
  namespace  = local.namespace

  values = [
    <<-EOF
    fullnameOverride: "${local.user_db_service_name}"
    image:
      tag: "${var.POSTGRES_VERSION}"
    auth:
      enablePostgresUser: false
      username: "${var.MISARCH_DB_USER}"
      database: "${var.MISARCH_DB_DATABASE}"
      password: "${random_password.misarch_user_db_password.result}"
    metrics:
      enabled: true
    EOF
  ]
}

