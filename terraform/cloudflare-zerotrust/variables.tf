variable "cloudflare_account_id" {
  type        = string
  sensitive   = true
  description = "Cloudflare Account ID"
}

variable "cloudflare_token" {
  type        = string
  sensitive   = true
  description = "Cloudflare API Token"
}

variable "cloudflare_github_client_id" {
  type        = string
  sensitive   = true
  description = "GitHub Client ID for SSO"
}

variable "cloudflare_github_client_secret" {
  type        = string
  sensitive   = true
  description = "GitHub Client Secret for SSO"
}

variable "cloudflare_clancy_secret" {
  type        = string
  sensitive   = true
  description = "Cloudflare Tunnel password"

  validation {
    condition     = can(regex("^[A-Za-z0-9+/]*={0,2}$", var.cloudflare_clancy_secret))
    error_message = "The value must be a base64-encoded string."
  }

  validation {
    condition     = length(var.cloudflare_clancy_secret) >= 32
    error_message = "The value must be 32 or more bytes in length."
  }
}

variable "cloudflare_zone_id" {
  type        = string
  description = "Cloudflare Zone ID"
}

variable "allow_status_list" {
  type = list(object({
    email  = list(string),
    github = map(string)
  }))
  description = "List of access conditions for Network Status page"
}

variable "allow_home_assistant_list" {
  type = list(object({
    email  = list(string),
    github = map(string)
  }))
  description = "List of access conditions for Home Assistant"
}

variable "allow_unifi_list" {
  type = list(object({
    email  = list(string),
    github = map(string)
  }))
  description = "List of access conditions for UniFi"
}

variable "allow_clancy_admin_list" {
  type = list(object({
    email  = list(string),
    github = map(string)
  }))
  description = "List of access conditions for Homer Admin"
}

variable "allow_homer_admin_list" {
  type = list(object({
    email  = list(string),
    github = map(string)
  }))
  description = "List of access conditions for Homer Admin"
}
