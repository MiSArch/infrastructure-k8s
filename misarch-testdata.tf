# resource "kubernetes_deployment" "misarch_testdata" {
#   depends_on = [kubernetes_deployment.keycloak, kubernetes_deployment.misarch_gateway]
#   metadata {
#
#     name      = local.misarch_testdata_service_name
#     labels    = merge(local.base_misarch_labels, local.misarch_testdata_specific_labels)
#     namespace = local.namespace
#   }
#
#   spec {
#     replicas = 1
#
#     selector {
#       match_labels = {
#         app = local.misarch_testdata_service_name
#       }
#     }
#
#     template {
#       metadata {
#         labels      = merge(local.base_misarch_labels, local.misarch_testdata_specific_labels)
#         annotations = merge(
#           local.base_misarch_annotations,
#           {
#             "dapr.io/enabled" = "false"
#           }
#         )
#       }
#
#       spec {
#
#         container {
#           image             = "ghcr.io/misarch/testdata:${var.MISARCH_TESTDATA_VERSION}"
#           image_pull_policy = "Always"
#
#           name = local.misarch_testdata_service_name
#
#           resources {
#             limits = {
#               cpu    = "100m"
#               memory = "400Mi"
#             }
#             requests = {
#               cpu    = "100m"
#               memory = "400Mi"
#             }
#           }
#
#           env_from {
#             config_map_ref {
#               name = local.misarch_base_env_vars_configmap
#             }
#           }
#           env_from {
#             config_map_ref {
#               name = local.misarch_testdata_env_vars_configmap
#             }
#           }
#         }
#       }
#     }
#   }
# }
