resource "helm_release" "influxdb" {
  name       = local.influxdb_service_name
  repository = "https://helm.influxdata.com"
  chart      = "influxdb2"
  namespace  = local.namespace

  values = [
    <<-EOF
    fullnameOverride: "${local.influxdb_service_name}"
    env:
      - name: DOCKER_INFLUXDB_INIT_MODE
        value: "setup"
      - name: DOCKER_INFLUXDB_INIT_USERNAME
        value: ${var.INFLUXDB_USER}
      - name: DOCKER_INFLUXDB_INIT_PASSWORD
        value: ${var.INFLUXDB_PASSWORD}
      - name: DOCKER_INFLUXDB_INIT_ORG
        value: "${var.INFLUXDB_ORG}"
      - name: DOCKER_INFLUXDB_INIT_BUCKET
        value: "${var.INFLUXDB_BUCKET}"
      - name: DOCKER_INFLUXDB_INIT_ADMIN_TOKEN
        value: "${random_password.influxdb_admin_token.result}"
    EOF
  ]
}

resource "random_password" "influxdb_admin_token" {
  length  = 32
  special = false
}

output "influxdb_admin_token" {
  value     = random_password.influxdb_admin_token.result
  sensitive = true
}

resource "kubernetes_secret" "influxdb_admin_token" {
  metadata {
    name      = "influxdb-admin-token"
    namespace = local.namespace
  }
  data = {
    DOCKER_INFLUXDB_INIT_ADMIN_TOKEN = random_password.influxdb_admin_token.result
  }
}