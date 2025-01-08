variable "cloudflare_token" {
  description = "Cloudflare API Token"
  type        = string
  sensitive   = true
}

variable "cloudflare_account_id" {
  description = "Cloudflare Account ID"
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
}

variable "do_token" {
  description = "DigitalOcean API Token"
  type        = string
  sensitive   = true
}

variable "hoopdev_db_pass" {
  description = "Password for hoop.devs DB"
  type        = string
  sensitive   = true
}

variable "hoopdev_oidc_id" {
  description = "OIDC client ID for hoop.dev"
  type        = string
  sensitive   = true
}

variable "hoopdev_oidc_secret" {
  description = "OIDC client secret for hoop.dev"
  type        = string
  sensitive   = true
}

variable "cloudflare_access_tunnel_mgmt_token" {
  description = "Token for the mgmt clusters Cloudflare Access tunnel"
  type        = string
  sensitive   = true
}