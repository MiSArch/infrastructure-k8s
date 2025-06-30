resource "helm_release" "influxdb" {
  name       = local.influxdb_service_name
  repository = "https://helm.influxdata.com"
  chart      = "influxdb"
  namespace  = local.namespace

  # TODO proper credentials
  values = [
    <<-EOF
    fullnameOverride: "${local.influxdb_service_name}"
    env:
      - name: DOCKER_INFLUXDB_INIT_MODE
        value: "setup"
      - name: DOCKER_INFLUXDB_INIT_USERNAME
        value: "admin"
      - name: DOCKER_INFLUXDB_INIT_PASSWORD
        value: "admin123"
      - name: DOCKER_INFLUXDB_INIT_ORG
        value: "misarch"
      - name: DOCKER_INFLUXDB_INIT_BUCKET
        value: "gatling"
      - name: DOCKER_INFLUXDB_INIT_ADMIN_TOKEN
        value: "my-secret-token"
    EOF
  ]
}