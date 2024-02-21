resource "helm_release" "keycloak" {
  name       = "keycloak"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "keycloak"
  namespace  = kubernetes_namespace.misarch.metadata[0].name

  values = [
    <<-EOF
    image:
      registry: "quay.io"
      repository: "keycloak/keycloak"
      tag: "${var.KEYCLOAK_VERSION}"
    podAnnotations:
      dapr.io/enabled: "true"
      dapr.io/app-id: "keycloak"
      dapr.io/app-port: "80"
      dapr.io/config: "tracing"
    auth:
      adminUser: admin
      adminPassword: ${var.KEYCLOAK_ADMIN_PASSWORD}
    proxy: "edge"
    production: true
    command: ["/opt/keycloak/bin/kc.sh"]
    args: ["start-dev", "--import-realm"] # When you change 'start-dev' to 'start' (so converting it into a production build), HTTPS is suddenly required even though proxy=edge, which should not happen as per the docs…
    postgresql:
      auth:
        username: "misarch"
        postgresPassword: "${random_password.keycloak_db_password.result}"
        database: "misarch"
    ingress:
      hostname: "${var.ROOT_DOMAIN}"
    metrics:
      enabled: true
    readinessProbe:
      initialDelaySeconds: 60
      timeoutSeconds: 10
    initContainers:
      - name: keycloak-plugin-initializer
        image: "ghcr.io/misarch/keycloak-user-creation-events:${var.KEYCLOAK_USER_EVENTS_PLUGIN_VERSION}"
        imagePullPolicy: Always
        volumeMounts:
          - name: misarch-keycloak-plugins
            mountPath: "/opt/keycloak/providers"
    extraEnvVars:
      - name: KC_HOSTNAME_STRICT
        value: "false"
    extraVolumes:
      - name: misarch-keycloak-realm
        configMap:
           name: misarch-keycloak-realm-config
      - name: misarch-keycloak-plugins
        persistentVolumeClaim:
           claimName: misarch-keycloak-plugin-volume
    extraVolumeMounts:
      - name: misarch-keycloak-realm
        mountPath: "/opt/keycloak/data/import"
      - name: misarch-keycloak-plugins
        mountPath: "/opt/keycloak/providers"
    EOF
  ]
}

resource "kubernetes_persistent_volume_claim" "misarch_keycloak_plugin_volume" {
  metadata {
    name      = "misarch-keycloak-plugin-volume"
    namespace = var.KUBERNETES_NAMESPACE
  }
  spec {
    storage_class_name = ""
    access_modes       = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1M" # Still FAR too large, that volume currently needs 8.2KB, but who cares, give it some space for future development
      }
    }
  }
}

resource "kubernetes_config_map" "misarch_keycloak_realm_config" {
  metadata {
    name      = "misarch-keycloak-realm-config"
    namespace = "misarch"
  }

  data = {
    "misarch-realm.json" = file("keycloak/keycloak-realm-template.json")
  }
}


