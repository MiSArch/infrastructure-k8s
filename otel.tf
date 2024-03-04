resource "helm_release" "otel-collector" {
  name       = local.otel_collector_service_name
  repository = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart      = "opentelemetry-collector"
  namespace  = local.namespace

  values = [
    <<-EOF
    mode: "deployment"
    EOF
  ]
}
