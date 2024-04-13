resource "kubernetes_ingress_v1" "misarch" {
  metadata {
    name      = local.misarch_ingress_name
    namespace = local.misarch_namespace
    annotations = merge(local.base_misarch_annotations, local.misarch_ingress_annotations)
  }

  spec {
    default_backend {
      service {
        name = local.misarch_frontend_service_name
        port {
          number = local.frontend_port
        }
      }
    }

    rule {
      http {
        path {
          backend {
            service {
              name = local.misarch_frontend_service_name
              port {
                number = local.frontend_port
              }
            }
          }
          path = "/"
        }
      }
    }
  }
}
