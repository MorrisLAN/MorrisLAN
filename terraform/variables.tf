variable "cloudflare_token" {
  description = "Cloudflare API Token"
  sensitive   = true
}

variable "cloudflare_account_id" {
  description = "Cloudflare Account ID"
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
}

variable "access_tunnel_clancy_password" {
  description = "Password for Clancy's Access Tunnel"
  sensitive   = true
}

variable "gh_client_id" {
  description = "GitHub Client ID"
  sensitive   = true
}

variable "gh_client_secret" {
  description = "GitHub Client Secret"
  sensitive   = true
}