locals {
  inventory_db_secret_name    = "mongodb-credentials-inventory"
  invoice_db_secret_name      = "mongodb-credentials-invoice"
  order_db_secret_name        = "mongodb-credentials-order"
  payment_db_secret_name      = "mongodb-credentials-payment"
  review_db_secret_name       = "mongodb-credentials-review"
  shoppingcart_db_secret_name = "mongodb-credentials-shoppingcart"
  wishlist_db_secret_name     = "mongodb-credentials-wishlist"
}

# Inventory
resource "helm_release" "misarch_inventory_db" {
  depends_on = [kubernetes_secret.mongodb_credentials_inventory]
  name       = local.inventory_db_service_name
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "mongodb"
  namespace  = local.namespace

  values = [
    <<-EOF
    fullnameOverride: "${local.inventory_db_service_name}"
    architecture: "replicaset"
    image:
      tag: "${var.MONGODB_VERSION}"
    auth:
      usernames: ["${var.MISARCH_DB_USER}"]
      databases: ["${var.MISARCH_DB_DATABASE}"]
      existingSecret: "${local.inventory_db_secret_name}"
    metrics:
      enabled: true
    EOF
  ]
}

resource "kubernetes_secret" "mongodb_credentials_inventory" {
  metadata {
    name      = local.inventory_db_secret_name
    namespace = local.namespace
  }

  data = {
    "mongodb-root-password"   = random_password.mongodb_root_password_inventory.result
    "mongodb-passwords"       = random_password.misarch_inventory_db_password.result
    "mongodb-replica-set-key" = random_password.mongodb_replica_set_key_inventory.result
  }
}

/* Uncomment once our cluster is powerful enough to handle the remaining DBs

# Invoice
resource "helm_release" "misarch_invoice_db" {
  depends_on = [kubernetes_secret.mongodb_credentials_invoice]
  name       = local.invoice_db_service_name
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "mongodb"
  namespace  = local.namespace

  values = [
    <<-EOF
    fullnameOverride: "${local.invoice_db_service_name}"
    architecture: "replicaset"
    image:
      tag: "${var.MONGODB_VERSION}"
    auth:
      usernames: ["${var.MISARCH_DB_USER}"]
      databases: ["${var.MISARCH_DB_DATABASE}"]
      existingSecret: "${local.invoice_db_secret_name}"
    metrics:
      enabled: true
    EOF
  ]
}

resource "kubernetes_secret" "mongodb_credentials_invoice" {
  metadata {
    name      = local.invoice_db_secret_name
    namespace = local.namespace
  }

  data = {
    "mongodb-root-password"     = random_password.mongodb_root_password_invoice.result
    "mongodb-passwords"         = random_password.misarch_invoice_db_password.result
    "mongodb-replica-set-key"   = random_password.mongodb_replica_set_key_invoice.result
  }
}

# Order
resource "helm_release" "misarch_order_db" {
  depends_on = [kubernetes_secret.mongodb_credentials_order]
  name       = local.order_db_service_name
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "mongodb"
  namespace  = local.namespace

  values = [
    <<-EOF
    fullnameOverride: "${local.order_db_service_name}"
    architecture: "replicaset"
    image:
      tag: "${var.MONGODB_VERSION}"
    auth:
      usernames: ["${var.MISARCH_DB_USER}"]
      databases: ["${var.MISARCH_DB_DATABASE}"]
      existingSecret: "${local.order_db_secret_name}"
    metrics:
      enabled: true
    EOF
  ]
}

resource "kubernetes_secret" "mongodb_credentials_order" {
  metadata {
    name      = local.order_db_secret_name
    namespace = local.namespace
  }

  data = {
    "mongodb-root-password"     = random_password.mongodb_root_password_order.result
    "mongodb-passwords"         = random_password.misarch_order_db_password.result
    "mongodb-replica-set-key"   = random_password.mongodb_replica_set_key_order.result
  }
}

# Payment
resource "helm_release" "misarch_payment_db" {
  depends_on = [kubernetes_secret.mongodb_credentials_payment]
  name       = local.payment_db_service_name
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "mongodb"
  namespace  = local.namespace

  values = [
    <<-EOF
    fullnameOverride: "${local.payment_db_service_name}"
    architecture: "replicaset"
    image:
      tag: "${var.MONGODB_VERSION}"
    auth:
      usernames: ["${var.MISARCH_DB_USER}"]
      databases: ["${var.MISARCH_DB_DATABASE}"]
      existingSecret: "${local.payment_db_secret_name}"
    metrics:
      enabled: true
    EOF
  ]
}

resource "kubernetes_secret" "mongodb_credentials_payment" {
  metadata {
    name      = local.payment_db_secret_name
    namespace = local.namespace
  }

  data = {
    "mongodb-root-password"     = random_password.mongodb_root_password_payment.result
    "mongodb-passwords"         = random_password.misarch_payment_db_password.result
    "mongodb-replica-set-key"   = random_password.mongodb_replica_set_key_payment.result
  }
}

# Review
resource "helm_release" "misarch_review_db" {
  depends_on = [kubernetes_secret.mongodb_credentials_review]
  name       = local.review_db_service_name
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "mongodb"
  namespace  = local.namespace

  values = [
    <<-EOF
    fullnameOverride: "${local.review_db_service_name}"
    architecture: "replicaset"
    image:
      tag: "${var.MONGODB_VERSION}"
    auth:
      usernames: ["${var.MISARCH_DB_USER}"]
      databases: ["${var.MISARCH_DB_DATABASE}"]
      existingSecret: "${local.review_db_secret_name}"
    metrics:
      enabled: true
    EOF
  ]
}

resource "kubernetes_secret" "mongodb_credentials_review" {
  metadata {
    name      = local.review_db_secret_name
    namespace = local.namespace
  }

  data = {
    "mongodb-root-password"     = random_password.mongodb_root_password_review.result
    "mongodb-passwords"         = random_password.misarch_review_db_password.result
    "mongodb-replica-set-key"   = random_password.mongodb_replica_set_key_review.result
  }
}

# ShoppingCart
resource "helm_release" "misarch_shoppingcart_db" {
  depends_on = [kubernetes_secret.mongodb_credentials_shoppingcart]
  name       = local.shoppingcart_db_service_name
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "mongodb"
  namespace  = local.namespace

  values = [
    <<-EOF
    fullnameOverride: "${local.shoppingcart_db_service_name}"
    architecture: "replicaset"
    image:
      tag: "${var.MONGODB_VERSION}"
    auth:
      usernames: ["${var.MISARCH_DB_USER}"]
      databases: ["${var.MISARCH_DB_DATABASE}"]
      existingSecret: "${local.shoppingcart_db_secret_name}"
    metrics:
      enabled: true
    EOF
  ]
}

resource "kubernetes_secret" "mongodb_credentials_shoppingcart" {
  metadata {
    name      = local.shoppingcart_db_secret_name
    namespace = local.namespace
  }

  data = {
    "mongodb-root-password"     = random_password.mongodb_root_password_shoppingcart.result
    "mongodb-passwords"         = random_password.misarch_shoppingcart_db_password.result
    "mongodb-replica-set-key"   = random_password.mongodb_replica_set_key_shoppingcart.result
  }
}

# Wishlist
resource "helm_release" "misarch_wishlist_db" {
  depends_on = [kubernetes_secret.mongodb_credentials_wishlist]
  name       = local.wishlist_db_service_name
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "mongodb"
  namespace  = local.namespace

  values = [
    <<-EOF
    fullnameOverride: "${local.wishlist_db_service_name}"
    architecture: "replicaset"
    image:
      tag: "${var.MONGODB_VERSION}"
    auth:
      usernames: ["${var.MISARCH_DB_USER}"]
      databases: ["${var.MISARCH_DB_DATABASE}"]
      existingSecret: "${local.wishlist_db_secret_name}"
    metrics:
      enabled: true
    EOF
  ]
}

resource "kubernetes_secret" "mongodb_credentials_wishlist" {
  metadata {
    name      = local.wishlist_db_secret_name
    namespace = local.namespace
  }

  data = {
    "mongodb-root-password"     = random_password.mongodb_root_password_wishlist.result
    "mongodb-passwords"         = random_password.misarch_wishlist_db_password.result
    "mongodb-replica-set-key"   = random_password.mongodb_replica_set_key_wishlist.result
  }
}

*/
