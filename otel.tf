resource "helm_release" "otel-collector" {
  name       = local.otel_collector_service_name
  repository = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart      = "opentelemetry-collector"
  namespace  = local.namespace

  values = [
    <<-EOF
    mode: "deployment"
    image:
      repository: "otel/opentelemetry-collector-k8s" # https://github.com/open-telemetry/opentelemetry-helm-charts/blob/main/charts/opentelemetry-collector/UPGRADING.md#0880-to-0890
    EOF
  ]
}
