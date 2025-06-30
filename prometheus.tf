resource "helm_release" "prometheus_grafana_stack" {
  name       = "prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = local.namespace

  # todo influx values in vars
  values = [
    <<-EOF
  prometheus:
    prometheusSpec:
      additionalScrapeConfigs:
        - job_name: 'otel-collector'
          scrape_interval: 5s
          static_configs:
            - targets: ['otel-collector-opentelemetry-collector.${local.namespace}.svc.cluster.local:8889']

  grafana:
    enabled: true
    datasources:
      datasources.yaml:
        apiVersion: 1
        datasources:
          - name: InfluxDB
            uid: influxdb_uid
            type: influxdb
            access: proxy
            url: http://${local.influxdb_url}
            jsonData:
              version: Flux
              organization: misarch
              defaultBucket: gatling
              httpMode: POST
            secureJsonData:
              token: my-secret-token

  EOF
  ]
}