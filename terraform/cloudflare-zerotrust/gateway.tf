resource "cloudflare_teams_location" "home" {
  account_id     = var.cloudflare_account_id
  name           = "Home"
  client_default = false
}

resource "cloudflare_teams_rule" "allow_morrislan" {
  account_id  = var.cloudflare_account_id
  name        = "Allow MorrisLAN"
  description = "Allow access to MorrisLAN resources"
  precedence  = 1
  enabled     = true
  action      = "allow"
  filters     = ["dns"]
  traffic     = "any(dns.domains[*] == \"morrislan.net\")"
}

resource "cloudflare_teams_rule" "block_threats" {
  account_id  = var.cloudflare_account_id
  name        = "Block Security Threats"
  description = "Block access to domains that are shown as threats in Cloudflare Radar"
  precedence  = 2
  enabled     = true
  action      = "block"
  filters     = ["dns"]
  traffic     = "any(dns.security_category[*] in {80 68 83 117 131 151 153 175 176}) or any(dns.content_category[*] in {32})"
  rule_settings {
    block_page_enabled = true
  }
}
