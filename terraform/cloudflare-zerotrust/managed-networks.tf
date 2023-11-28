resource "cloudflare_device_managed_networks" "home" {
  account_id = var.cloudflare_account_id
  name       = "Home"
  type       = "tls"
  config {
    tls_sockaddr = "10.1.240.3:2053"
    sha256       = "B2EE7BF048412DED2198DCEB3E75B9EF8831C24F31B9D5F71D21A0C55C9284B7"
  }
}