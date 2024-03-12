resource "helm_release" "redis" {
  depends_on = [kubernetes_namespace.misarch]
  name       = "redis"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
  namespace  = local.namespace

  values = [
  <<-EOF
  auth:
    password: "${random_password.redis.result}"
  # Everything depends on redis being ready quickly, so decrease the preset timelimit and rather let it fail a few times to save some setup time
  master:
    readinessProbe:
      initialDelaySeconds: 10
  slave:
    readinessProbe:
      initialDelaySeconds: 10
  EOF
  ]
}

resource "helm_release" "dapr" {
  depends_on = [helm_release.redis]
  name       = "dapr"
  repository = "https://dapr.github.io/helm-charts"
  chart      = "dapr"
  namespace  = local.namespace
}

resource "kubectl_manifest" "dapr_state_config" {
  depends_on = [helm_release.dapr]
  yaml_body  = <<-EOF
  apiVersion:  "dapr.io/v1alpha1"
  kind: "Component"
  metadata:
    name: "statestore"
    namespace: ${local.namespace}

  spec:
    type: "state.redis"
    version: "v1"

    metadata:
      - name: "redisHost"
        value: "redis-master:6379"
      - name: "redisPassword"
        value: ${random_password.redis.result}
  EOF
}

resource "kubectl_manifest" "dapr_pubsub_config" {
  depends_on = [helm_release.dapr]
  yaml_body  = <<-EOF
  apiVersion:  "dapr.io/v1alpha1"
  kind: "Component"
  metadata:
    name: "pubsub"
    namespace: ${local.namespace}

  spec:
    type: "pubsub.redis"
    version: "v1"

    metadata:
      - name: "redisHost"
        value: "redis-master:6379"
      - name: "redisPassword"
        value: ${random_password.redis.result}
  EOF
}

resource "kubectl_manifest" "dapr_config" {
  depends_on = [helm_release.dapr]
  yaml_body  = <<-EOF
    apiVersion: dapr.io/v1alpha1
    kind: Configuration
    metadata:
      name: "${local.dapr_general_config_name}"
      namespace: "${local.namespace}"
    spec:
      tracing:
        samplingRate: "1"
        otel:
          endpointAddress: ${local.otel_collector_url}
          protocol: grpc
          isSecure: false
  EOF
}

// Pseudo resource so that all services can simply depend on this resource instead of the whole list ↓
resource "terraform_data" "dapr" {
  depends_on = [helm_release.dapr, kubectl_manifest.dapr_config, kubectl_manifest.dapr_pubsub_config, kubectl_manifest.dapr_state_config]
}
