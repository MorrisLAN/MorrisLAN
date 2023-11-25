variable "env" {
  type        = string
  description = "Specify the environment (prod or dev)"

  validation {
    condition     = var.env == "prod" || var.env == "dev"
    error_message = "Environment must be either 'prod' or 'dev'"
  }
}

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

variable "access_tunnel_clancy_password" {
  description = "Password for Clancy's Access Tunnel"
  type        = string
  sensitive   = true
}

variable "gh_client_id" {
  description = "GitHub Client ID"
  type        = string
  sensitive   = true
}

variable "gh_client_secret" {
  description = "GitHub Client Secret"
  type        = string
  sensitive   = true
}
