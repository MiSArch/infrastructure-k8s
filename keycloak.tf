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
    auth:
      adminUser: admin
      adminPassword: ${var.KEYCLOAK_ADMIN_PASSWORD}
    proxy: "edge"
    production: true
    httpRelativePath: "/keycloak/"
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
    extraEnvVars:
      - name: KC_HOSTNAME_STRICT
        value: "false"
      - name: KC_OVERRIDE
        value: "false"
    extraVolumes:
      - name: misarch-keycloak-realm
        configMap:
           name: misarch-keycloak-realm-config
    extraVolumeMounts:
      - name: misarch-keycloak-realm
        mountPath: "/opt/bitnami/keycloak/data/import"
    EOF
  ]
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


