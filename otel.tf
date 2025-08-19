resource "helm_release" "otel-collector" {
  name       = local.otel_collector_service_name
  repository = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart      = "opentelemetry-collector"
  namespace  = local.namespace

  values = [
    <<-EOF
    mode: "deployment"
    image:
      repository: "otel/opentelemetry-collector"
      tag: ${var.OTEL_COLLECTOR_VERSION}
    service:
      enabled: true
      type: ClusterIP
    ports:
      metrics:
        enabled: true
        containerPort: 8889
        servicePort: 8889
        protocol: TCP
    config:
      receivers:
        otlp:
          protocols:
            grpc:
              endpoint: "$${MY_POD_IP}:4317"
            http:
              endpoint: "$${MY_POD_IP}:4318"

        prometheus:
          config:
            scrape_configs:
              - job_name: 'dapr-metrics'
                scrape_interval: 5s
                kubernetes_sd_configs:
                  - role: pod
                relabel_configs:
                  - source_labels: [__meta_kubernetes_pod_label_app]
                    action: keep
                    regex: keycloak|misarch-(address|catalog|discount|gateway|inventory|invoice|media|notification|order|payment|return|review|shipment|shoppingcart|simulation|tax|user|wishlist)

      exporters:
        prometheus:
          endpoint: "0.0.0.0:8889"

      service:
        pipelines:
          metrics:
            receivers: [otlp, prometheus]
            exporters: [prometheus]
        telemetry:
          logs:
            level: "error"
    EOF
  ]
}

resource "kubernetes_cluster_role" "otel_collector_prom_sd" {
  metadata {
    name = "otel-collector-prometheus-sd"
  }

  rule {
    api_groups = [""]
    resources  = ["pods"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role_binding" "otel_collector_prom_sd" {
  metadata {
    name = "otel-collector-prometheus-sd"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.otel_collector_prom_sd.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = "otel-collector-opentelemetry-collector"
    namespace = local.namespace
  }
}
