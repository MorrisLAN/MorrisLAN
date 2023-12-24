variable "cloudflare_account_id" {
  type        = string
  sensitive   = true
  description = "Cloudflare Account ID"
}

variable "cloudflare_zone_id" {
  type        = string
  description = "Cloudflare Zone ID"
}

variable "cloudflare_token" {
  type        = string
  sensitive   = true
  description = "Cloudflare API Token"
}

variable "github_client_id" {
  type        = string
  sensitive   = true
  description = "GitHub Client ID for SSO"
}

variable "github_client_secret" {
  type        = string
  sensitive   = true
  description = "GitHub Client Secret for SSO"
}

resource "random_password" "tunnel_secret" {
  length = 64
}

resource "random_password" "dovpc_tunnel_secret" {
  length = 64
}