resource "helm_release" "dapr" {
  name       = "dapr"
  repository = "https://dapr.github.io/helm-charts"
  chart      = "dapr"
  namespace  = local.namespace
}


resource "helm_release" "redis" {
  name       = "redis"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
  namespace  = local.namespace

  set {
    name  = "auth.password"
    value = random_password.redis.result
  }
}

resource "kubectl_manifest" "dapr_state_config" {
  depends_on = [kubernetes_namespace.misarch]
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
  depends_on = [kubernetes_namespace.misarch]
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
