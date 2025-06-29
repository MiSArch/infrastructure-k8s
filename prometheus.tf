resource "helm_release" "prometheus_grafana_stack" {
  name       = "prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = local.namespace

  values = [
    <<-EOF
  prometheus:
    prometheusSpec:
      additionalScrapeConfigs:
        - job_name: 'otel-collector'
          scrape_interval: 5s
          static_configs:
            - targets: ['otel-collector-opentelemetry-collector.${local.namespace}.svc.cluster.local:8889']
  EOF
  ]
}