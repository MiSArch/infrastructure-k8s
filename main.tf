provider "kubernetes" {
  config_path = var.kubernetes_config_path
}

provider "helm" {
  kubernetes {
    config_path = var.kubernetes_config_path
  }
}

resource "kubernetes_namespace" "misarch" {
  metadata {
    name = var.kubernetes_namespace
  }
}

/*
# Uncomment once we use private Docker images
resource "kubernetes_secret" "image_pull" {
  metadata {
    name      = "github-container-secret"
    namespace = kubernetes_namespace.misarch.metadata[0].name
  }

  data = {
    ".dockerconfigjson" = var.image_pull_secret
  }

  type = "kubernetes.io/dockerconfigjson"
}
*/

