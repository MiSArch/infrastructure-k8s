resource "kubernetes_ingress_v1" "misarch" {
  metadata {
    name        = local.ingress_name
    namespace   = local.namespace
    annotations = merge(local.base_misarch_annotations, local.misarch_ingress_annotations)
  }

  spec {
    default_backend {
      service {
        name = "prometheus-stack-grafana"
        port {
          number = local.frontend_port
        }
      }
    }

    rule {
      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = "prometheus-stack-grafana"
              port {
                number = local.frontend_port
              }
            }
          }
        }
      }
    }

    rule {
      http {
        path {
          path      = "/experiment"
          path_type = "Prefix"

          backend {
            service {
              name = local.misarch_experiment_executor_service_name
              port {
                number = local.experiment_executor_port
              }
            }
          }
        }
      }
    }
    rule {
      http {
        path {
          path      = "/frontend"
          path_type = "Prefix"

          backend {
            service {
              name = local.misarch_experiment_executor_frontend_service_name
              port {
                number = local.frontend_port
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "misarch_frontend_service" {
  metadata {
    name      = local.misarch_frontend_service_name
    namespace = local.namespace
    labels    = merge(local.base_misarch_labels, local.misarch_frontend_specific_labels)
  }

  spec {
    selector = {
      app = local.misarch_frontend_service_name
    }

    port {
      protocol    = "TCP"
      port        = local.frontend_port
      target_port = local.frontend_port
    }

    type = "ClusterIP"
  }
}

