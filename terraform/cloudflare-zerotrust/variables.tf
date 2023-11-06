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

variable "access_tunnel_clancy_password" {
  type        = string
  sensitive   = true
  description = "Access Tunnel password for clancy.morrislan.net"

  validation {
    condition     = can(regex("^[A-Za-z0-9+/]*={0,2}$", var.access_tunnel_clancy_password))
    error_message = "The value must be a base64-encoded string."
  }

  validation {
    condition     = length(var.access_tunnel_clancy_password) >= 32
    error_message = "The value must be 32 or more bytes in length."
  }
}

variable "access_app_status_policy" {
  type = list(object({
    email  = list(string),
    github = map(string)
  }))
  description = "List of access conditions for Network Status Access App"
}

variable "access_app_ha_policy" {
  type = list(object({
    email  = list(string),
    github = map(string)
  }))
  description = "List of access conditions for Home Assistant Access App"
}

variable "access_app_unifi_policy" {
  type = list(object({
    email  = list(string),
    github = map(string)
  }))
  description = "List of access conditions for UniFi Access App"
}

variable "access_app_clancyadmin_policy" {
  type = list(object({
    email  = list(string),
    github = map(string)
  }))
  description = "List of access conditions for Clancy Admin Access App"
}

variable "access_app_homeradmin_policy" {
  type = list(object({
    email  = list(string),
    github = map(string)
  }))
  description = "List of access conditions for Homer Admin Access App"
}
