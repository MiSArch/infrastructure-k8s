locals {
  base_misarch_labels = {}
}

locals {
  misarch_catalog_specific_labels = {
    app = local.misarch_catalog_service_name
  }
}
