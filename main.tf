provider "kubernetes" {
  config_path = var.KUBERNETES_CONFIG_PATH
}

provider "helm" {
  kubernetes {
    config_path = var.KUBERNETES_CONFIG_PATH
  }
}

resource "kubernetes_namespace" "misarch" {
  metadata {
    name = var.KUBERNETES_NAMESPACE
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
    ".dockerconfigjson" = var.IMAGE_PULL_SECRET
  }

  type = "kubernetes.io/dockerconfigjson"
}
*/

