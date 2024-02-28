variable "BASE_MISARCH_ANNOTATIONS" {
  type        = map(any)
  description = "K8s annotations applied to any Misarch deployment"
  default = {
    "dapr.io/enabled"   = true
    "dapr.io/http-port" = 3500
    "dapr.io/config"    = "daprConfig",
  }
}

variable "MISARCH_CATALOG_SPECIFIC_ANNOTATIONS" {
  type        = map(any)
  description = "Catalog specific annotations"
  default = {
    "dapr.io/app-id"   = "catalog"
    "dapr.io/app-port" = 8080
  }
}
