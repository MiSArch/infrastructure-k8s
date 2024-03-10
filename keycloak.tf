locals {
  keycloak_annotations = yamlencode(merge(local.base_misarch_annotations, local.keycloak_specific_annotations))
}

resource "helm_release" "keycloak" {
  name       = "keycloak"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "keycloak"
  namespace  = local.namespace

  values = [
    <<-EOF
    image:
      tag: "${var.KEYCLOAK_VERSION}"
    podAnnotations:
      ${replace(local.keycloak_annotations, "/\n/", "\n  ")}
    auth:
      adminUser: admin
      adminPassword: ${var.KEYCLOAK_ADMIN_PASSWORD}
    proxy: "edge"
    production: true
    postgresql:
      auth:
        username: "misarch"
        password: "${random_password.keycloak_db_password.result}"
        database: "misarch"
    ingress:
      hostname: "${var.ROOT_DOMAIN}"
    metrics:
      enabled: true
    initContainers:
      - name: keycloak-plugin-initializer
        image: "ghcr.io/misarch/keycloak-user-creation-events:${var.KEYCLOAK_USER_EVENTS_PLUGIN_VERSION}"
        imagePullPolicy: Always
        volumeMounts:
          - name: misarch-keycloak-plugins
            mountPath: "/opt/bitnami/keycloak/providers"
    extraEnvVarsCM: "${local.keycloak_env_vars_configmap}"
    extraVolumes:
      - name: misarch-keycloak-realm
        configMap:
           name: misarch-keycloak-realm-config
      - name: misarch-keycloak-plugins
        persistentVolumeClaim:
           claimName: misarch-keycloak-plugin-volume
    extraVolumeMounts:
      - name: misarch-keycloak-realm
        mountPath: "/opt/bitnami/keycloak/data/import"
      - name: misarch-keycloak-plugins
        mountPath: "/opt/bitnami/keycloak/providers"
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
