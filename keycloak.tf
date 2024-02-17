resource "helm_release" "keycloak" {
  name       = "keycloak"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "keycloak"
  namespace  = kubernetes_namespace.misarch.metadata[0].name

  values = [
    <<-EOF
    auth:
      adminUser: admin
      adminPassword: ${var.KEYCLOAK_ADMIN_PASSWORD}
    production: true
    proxy: edge
    httpRelativePath: "/keycloak/"
    image:
      registry: "ghcr.io"
      repository: "misarch/keycloak"
      tag: "${var.KEYCLOAK_VERSION}"
    postgresql:
      auth:
        username: "misarch"
        postgresPassword: "${random_password.keycloak_db_password.result}"
        database: "misarch"
    extraEnv:
      - name: KC_DB_URL
        value: "jdbc:postgresql://keycloak-postgresql.default.svc.cluster.local:5432/misarch"
    EOF
  ]
}

