locals {
  minio_annotations = yamlencode(merge(local.base_misarch_annotations, local.minio_specific_annotations))
  minio_labels      = yamlencode(merge(local.base_misarch_labels, local.minio_specific_labels))
}

resource "helm_release" "minio" {
  name       = "minio"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "minio"
  namespace  = local.namespace

  values = [
    <<-EOF
    image:
      tag: "${var.MINIO_VERSION}"
    commonAnnotations:
      ${replace(local.minio_annotations, "/\n/", "\n  ")}
    commonLabels:
      ${replace(local.minio_labels, "/\n/", "\n  ")}
    fullnameOverride: "${local.minio_service_name}"
    mode: "distributed" # Use replicas
    auth:
      rootUser: "admin" # default of the Helm chart, lock it for the future
      rootPassword: "${random_password.minio_admin_password.result}"
    metrics:
      enabled: true
    persistence:
      mountPath: "/bitnami/minio/data" # default of the Helm chart, locked to keep it like that in the future
    extraEnvVarsCM: "${local.minio_env_vars_configmap}"
    EOF
  ]
}
