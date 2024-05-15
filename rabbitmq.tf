locals {
  rabbitmq_annotations = yamlencode(merge(local.base_misarch_annotations, local.rabbitmq_specific_annotations))
  rabbitmq_labels      = yamlencode(merge(local.base_misarch_labels, local.rabbitmq_specific_labels))
}

resource "helm_release" "rabbitmq" {
  name       = "rabbitmq"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "rabbitmq"
  namespace  = local.namespace

  values = [
    <<-EOF
    image:
      tag: "${var.RABBITMQ_VERSION}"
    commonAnnotations:
      ${replace(local.rabbitmq_annotations, "/\n/", "\n  ")}
    commonLabels:
      ${replace(local.rabbitmq_labels, "/\n/", "\n  ")}
    fullnameOverride: "${local.rabbitmq_service_name}"
    auth:
      user: "${var.MISARCH_DB_USER}"
      password: "${random_password.rabbitmq_password.result}"
      erlangCookie: "${var.RABBITMQ_ERLANG_COOKIE}"
    metrics:
      enabled: true
    extraEnvVarsCM: "${local.rabbitmq_env_vars_configmap}"
    EOF
  ]
}