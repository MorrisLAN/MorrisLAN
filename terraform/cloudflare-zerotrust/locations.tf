resource "cloudflare_teams_location" "home" {
  account_id     = var.cloudflare_account_id
  name           = "Home"
  client_default = false
}