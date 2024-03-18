# Inventory Service
resource "random_password" "mongodb_root_password_inventory" {
  length  = 32
  special = false
}

resource "random_password" "mongodb_replica_set_key_inventory" {
  length  = 32
  special = false
}

output "mongodb_root_password_inventory" {
  value     = random_password.mongodb_root_password_inventory.result
  sensitive = true
}

output "mongodb_replica_set_key_inventory" {
  value     = random_password.mongodb_replica_set_key_inventory.result
  sensitive = true
}

# Invoice Service
resource "random_password" "mongodb_root_password_invoice" {
  length  = 32
  special = false
}

resource "random_password" "mongodb_replica_set_key_invoice" {
  length  = 32
  special = false
}

output "mongodb_root_password_invoice" {
  value     = random_password.mongodb_root_password_invoice.result
  sensitive = true
}

output "mongodb_replica_set_key_invoice" {
  value     = random_password.mongodb_replica_set_key_invoice.result
  sensitive = true
}

# Order Service
resource "random_password" "mongodb_root_password_order" {
  length  = 32
  special = false
}

resource "random_password" "mongodb_replica_set_key_order" {
  length  = 32
  special = false
}

output "mongodb_root_password_order" {
  value     = random_password.mongodb_root_password_order.result
  sensitive = true
}

output "mongodb_replica_set_key_order" {
  value     = random_password.mongodb_replica_set_key_order.result
  sensitive = true
}

# Payment Service
resource "random_password" "mongodb_root_password_payment" {
  length  = 32
  special = false
}

resource "random_password" "mongodb_replica_set_key_payment" {
  length  = 32
  special = false
}

output "mongodb_root_password_payment" {
  value     = random_password.mongodb_root_password_payment.result
  sensitive = true
}

output "mongodb_replica_set_key_payment" {
  value     = random_password.mongodb_replica_set_key_payment.result
  sensitive = true
}

# Review Service
resource "random_password" "mongodb_root_password_review" {
  length  = 32
  special = false
}

resource "random_password" "mongodb_replica_set_key_review" {
  length  = 32
  special = false
}

output "mongodb_root_password_review" {
  value     = random_password.mongodb_root_password_review.result
  sensitive = true
}

output "mongodb_replica_set_key_review" {
  value     = random_password.mongodb_replica_set_key_review.result
  sensitive = true
}

# ShoppingCart Service
resource "random_password" "mongodb_root_password_shoppingcart" {
  length  = 32
  special = false
}

resource "random_password" "mongodb_replica_set_key_shoppingcart" {
  length  = 32
  special = false
}

output "mongodb_root_password_shoppingcart" {
  value     = random_password.mongodb_root_password_shoppingcart.result
  sensitive = true
}

output "mongodb_replica_set_key_shoppingcart" {
  value     = random_password.mongodb_replica_set_key_shoppingcart.result
  sensitive = true
}

# Wishlist Service
resource "random_password" "mongodb_root_password_wishlist" {
  length  = 32
  special = false
}

resource "random_password" "mongodb_replica_set_key_wishlist" {
  length  = 32
  special = false
}

output "mongodb_root_password_wishlist" {
  value     = random_password.mongodb_root_password_wishlist.result
  sensitive = true
}

output "mongodb_replica_set_key_wishlist" {
  value     = random_password.mongodb_replica_set_key_wishlist.result
  sensitive = true
}

