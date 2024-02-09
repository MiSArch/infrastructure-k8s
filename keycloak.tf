resource "helm_release" "keycloak" {
  name       = "keycloak"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "keycloak"
  namespace  = kubernetes_namespace.misarch.metadata[0].name

  set {
    name  = "auth.adminUser"
    value = "admin"
  }

  set {
    name  = "auth.adminPassword"
    value = var.KEYCLOAK_ADMIN_PASSWORD
  }
  set {
    name  = "production"
    value = "true"
  }
  set {
    name  = "proxy"
    value = "edge"
  }
  set {
    name  = "httpRelativePath"
    value = "/keycloak/"
  }
  set {
    name  = "image.registry"
    value = "ghcr.io"
  }
  set {
    name  = "image.repository"
    value = "misarch/keycloak"
  }
  set {
    name  = "image.tag"
    value = var.KEYCLOAK_VERSION
  }
  set {
    name  = "postgresql.auth.username"
    value = "misarch"
  }
  set {
    name  = "postgresql.auth.postgresPassword"
    value = random_password.keycloak_db_password.result
  }
  set {
    name  = "postgresql.auth.database"
    value = "misarch"
  }
}
