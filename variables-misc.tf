variable "KUBERNETES_CONFIG_PATH" {
  sensitive = true
  type      = string
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

variable "RABBITMQ_ERLANG_COOKIE" {
  type = string
  default = "RABBITMQ_MISARCH_ERLANG_COOKIE"
}

locals {
  dapr_general_config_name = "dapr-config"
}
