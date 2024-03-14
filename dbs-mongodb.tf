resource "helm_release" "misarch_inventory_db" {
  name       = local.inventory_db_service_name
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "mongodb"
  namespace  = local.namespace

  values = [
    <<-EOF
    fullnameOverride: "${local.inventory_db_service_name}"
    architecture: "replicaset"
    image:
      tag: "${var.MONGODB_VERSION}"
    auth:
      usernames: ["${var.MISARCH_DB_USER}"]
      databases: ["${var.MISARCH_DB_DATABASE}"]
      passwords: ["${random_password.misarch_address_db_password.result}"]
    metrics:
      enabled: true
    EOF
  ]
}
