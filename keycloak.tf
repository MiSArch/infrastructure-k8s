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
    value = var.keycloak_admin_password
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
    name  = "global.imagePullSecrets.0"
    value = kubernetes_secret.image_pull.metadata[0].name
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
    value = var.keycloak_version
  }
}
