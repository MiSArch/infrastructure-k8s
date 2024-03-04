// Passwords
resource "random_password" "keycloak_db_password" {
  length  = 32
  special = false
}

resource "random_password" "misarch_address_db_password" {
  length  = 32
  special = false
}

resource "random_password" "misarch_catalog_db_password" {
  length  = 32
  special = false
}

resource "random_password" "misarch_discount_db_password" {
  length  = 32
  special = false
}

resource "random_password" "misarch_inventory_db_password" {
  length  = 32
  special = false
}

resource "random_password" "misarch_invoice_db_password" {
  length  = 32
  special = false
}

resource "random_password" "misarch_media_db_password" {
  length  = 32
  special = false
}

resource "random_password" "misarch_notification_db_password" {
  length  = 32
  special = false
}

resource "random_password" "misarch_order_db_password" {
  length  = 32
  special = false
}

resource "random_password" "misarch_payment_db_password" {
  length  = 32
  special = false
}

resource "random_password" "misarch_review_db_password" {
  length  = 32
  special = false
}

resource "random_password" "misarch_return_db_password" {
  length  = 32
  special = false
}

resource "random_password" "misarch_shipment_db_password" {
  length  = 32
  special = false
}

resource "random_password" "misarch_shoppingcart_db_password" {
  length  = 32
  special = false
}

resource "random_password" "misarch_tax_db_password" {
  length  = 32
  special = false
}

resource "random_password" "misarch_user_db_password" {
  length  = 32
  special = false
}

resource "random_password" "misarch_wishlist_db_password" {
  length  = 32
  special = false
}

resource "random_password" "redis" {
  length  = 32
  special = false
}




// Ouputs for these passwords




output "keycloak_db_password" {
  value = random_password.keycloak_db_password.result
  sensitive = true
}

output "misarch_address_db_password" {
  value = random_password.misarch_address_db_password.result
  sensitive = true
}

output "misarch_catalog_db_password" {
  value = random_password.misarch_catalog_db_password.result
  sensitive = true
}

output "misarch_discount_db_password" {
  value = random_password.misarch_discount_db_password.result
  sensitive = true
}

output "misarch_inventory_db_password" {
  value = random_password.misarch_inventory_db_password.result
  sensitive = true
}

output "misarch_invoice_db_password" {
  value = random_password.misarch_invoice_db_password.result
  sensitive = true
}

output "misarch_media_db_password" {
  value = random_password.misarch_media_db_password.result
  sensitive = true
}

output "misarch_notification_db_password" {
  value = random_password.misarch_notification_db_password.result
  sensitive = true
}

output "misarch_order_db_password" {
  value = random_password.misarch_order_db_password.result
  sensitive = true
}

output "misarch_payment_db_password" {
  value = random_password.misarch_payment_db_password.result
  sensitive = true
}

output "misarch_review_db_password" {
  value = random_password.misarch_review_db_password.result
  sensitive = true
}

output "misarch_return_db_password" {
  value = random_password.misarch_return_db_password.result
  sensitive = true
}

output "misarch_shipment_db_password" {
  value = random_password.misarch_shipment_db_password.result
  sensitive = true
}

output "misarch_shoppingcart_db_password" {
  value = random_password.misarch_shoppingcart_db_password.result
  sensitive = true
}

output "misarch_tax_db_password" {
  value = random_password.misarch_tax_db_password.result
  sensitive = true
}

output "misarch_user_db_password" {
  value = random_password.misarch_user_db_password.result
  sensitive = true
}

output "misarch_wishlist_db_password" {
  value = random_password.misarch_wishlist_db_password.result
  sensitive = true
}

output "redis_password" {
  value = random_password.redis.result
  sensitive = true
}

