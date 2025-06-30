variable "KUBERNETES_CONFIG_PATH" {
  sensitive = true
  type      = string
  default   = "~/.kube/config"
}

variable "KUBERNETES_NAMESPACE" {
  type    = string
  default = "misarch"
}

variable "MISARCH_DB_USER" {
  type    = string
  default = "misarch"
}

variable "MISARCH_DB_DATABASE" {
  type    = string
  default = "misarch"
}

variable "KEYCLOAK_DB_USER" {
  type    = string
  default = "postgres"
}

variable "KEYCLOAK_DB_DATABASE" {
  type    = string
  default = "keycloak"
}

variable "MISARCH_SIMULATION_PAYMENTS_PER_MINUTE" {
  type    = number
  default = 10000000
}

variable "MISARCH_SIMULATION_SHIPMENTS_PER_MINUTE" {
  type    = number
  default = 10000000
}

variable "MISARCH_SIMULATION_PROCESSING_TIME_SECONDS" {
  type    = number
  default = 5
}

variable "MONGODB_RESOURCE_PRESET" {
  type = string
  description = "Sets a resource limit for MongoDBs. Values are as described in https://github.com/bitnami/charts/blob/4b89068b8267e4b115c676064d092a05813953cc/bitnami/common/templates/_resources.tpl#L16-L43. Default is 'micro', Helm Chart default was 'small'."
  default = "micro"
}

variable "RABBITMQ_ERLANG_COOKIE" {
  type = string
  default = "RABBITMQ_MISARCH_ERLANG_COOKIE"
}

locals {
  dapr_general_config_name = "dapr-config"
}
