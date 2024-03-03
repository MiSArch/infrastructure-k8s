locals {
  base_misarch_annotations = {
    "dapr.io/enabled"   = true
    "dapr.io/http-port" = 3500
    "dapr.io/config"    = local.dapr_general_config_name
  }
}

locals {
  misarch_catalog_specific_annotations = {
    "dapr.io/app-id"   = "catalog"
    "dapr.io/app-port" = 8080
  }
}
