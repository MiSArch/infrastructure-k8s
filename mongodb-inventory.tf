/*
locals {
  inventory_db_password_secret_name = "misarch-inventory-db-password"
}

resource "helm_release" "mongodb_operator_inventory" {
  depends_on = [helm_release.mongodb_crds, kubernetes_secret.inventory_db_password]
  name       = local.inventory_db_service_name
  repository = "https://mongodb.github.io/helm-charts"
  chart      = "community-operator"
  namespace  = local.namespace

  values = [
    <<-EOF
    operator:
      # name: "${local.inventory_db_service_name}"
      version: "${var.MONGODB_OPERATOR_VERSION}"
    community-operator-crds:
      enabled: false
    createResource: true
    database:
      name: "${local.inventory_db_service_name}" # Yes, this option is undocumented…
      namespace: "${local.namespace}" # Yes, this option is undocumented…
    resource:
      name: "${local.inventory_db_service_name}"
      users:
      - name: "${var.MISARCH_DB_USER}"
        db: "${var.MISARCH_DB_DATABASE}"
        passwordSecretRef:
          name: ${local.inventory_db_password_secret_name}
        roles:
        - name: dbAdmin
          db: "${var.MISARCH_DB_DATABASE}"
        scramCredentialsSecretName: inventory
    EOF
  ]
}

resource "kubernetes_secret" "inventory_db_password" {
  metadata {
    name = local.inventory_db_password_secret_name
    namespace = local.namespace
  }

  data = {
    password = random_password.misarch_inventory_db_password.result
  }

  type = "Opaque"
}

/*
resource "kubectl_manifest" "inventory-db-config" {
  depends_on = [helm_release.mongodb_operator_inventory]
  yaml_body = <<-EOF
  apiVersion: mongodbcommunity.mongodb.com/v1
  kind: MongoDBCommunity
  metadata:
    name:  "${local.inventory_db_service_name}"
  spec:
    members: 3
    type: ReplicaSet
    version: "${var.MONGODB_VERSION}"
    security:
      authentication:
        modes: ["SCRAM"]
    users:
      - name: "${var.MISARCH_DB_USER}"
        db: "${var.MISARCH_DB_DATABASE}"
        passwordSecretRef:
          name: ${local.inventory_db_password_secret_name}
        roles:
        - name: dbAdmin
          db: "${var.MISARCH_DB_DATABASE}"
        scramCredentialsSecretName: inventory
  EOF
}
*/
