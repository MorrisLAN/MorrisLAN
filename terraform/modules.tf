module "static_site" {
  source           = "m4xmorris/static-site/digitalocean"
  version          = "1.3.2"
  site_name        = "morrislan"
  external_project = "27ecab9a-b47f-4e38-a3bf-7f43c886e3a3"
  description      = "Webroot for MorrisLAN"
  environment      = "Production"
  region           = "lon"
  domain           = "morrislan.net"
  source_repo      = "MorrisLAN/morrislan"
  source_branches = {
    "main" = "/"
  }
  source_dir         = "http"
  output_dir         = "."
  build_command      = "echo 'Static HTML, no build required.'"
  manage_dns         = true
  cloudflare_zone_id = var.cloudflare_zone_id
  alert_policy = [
    "DOMAIN_LIVE",
    "DEPLOYMENT_LIVE",
    "DOMAIN_FAILED",
    "DEPLOYMENT_FAILED"
  ]
}

module "vapor" {
  source             = "./vapor"
  digitalocean_token = var.digitalocean_token
}