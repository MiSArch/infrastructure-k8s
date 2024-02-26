terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14.0"
    }
  }
}

provider "kubernetes" {
  config_path = var.KUBERNETES_CONFIG_PATH
}

provider "helm" {
  kubernetes {
    config_path = var.KUBERNETES_CONFIG_PATH
  }
}

provider "kubectl" {
  config_path = var.KUBERNETES_CONFIG_PATH
}

resource "kubernetes_namespace" "misarch" {
  metadata {
    name = var.KUBERNETES_NAMESPACE
  }
}

locals {
  namespace = kubernetes_namespace.misarch.metadata[0].name
}

