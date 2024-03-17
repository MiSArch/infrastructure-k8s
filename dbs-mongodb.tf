locals {
  inventory_db_secret_name = "mongodb-credentials-inventory"
}

resource "helm_release" "misarch_inventory_db" {
  depends_on = [kubernetes_secret.mongodb_credentials_inventory]
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
      # passwords: ["${random_password.misarch_address_db_password.result}"] # Not necessary, overridden by secret below
      existingSecet: "${local.inventory_db_secret_name}"
    metrics:
      enabled: true
    EOF
  ]
}

resource "kubernetes_secret" "mongodb_credentials_inventory" {
  metadata {
    name      = local.inventory_db_secret_name
    namespace = local.namespace
  }

  data = {
    "mongodb-root-password"     = random_password.mongodb_root_password_inventory.result
    "mongodb-passwords"         = random_password.misarch_inventory_db_password.result
    "mongodb-replica-set-key"   = random_password.mongodb_replica_set_key_inventory.result
    # Omitting mongodb-metrics-password as it's not necessary
  }
}
