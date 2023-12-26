variable "cloudflare_token" {
  description = "Cloudflare API Token"
  type        = string
  sensitive   = true
}

variable "do_token" {
  description = "DigitalOcean API Token"
  type        = string
  sensitive   = true
}

variable "do_spaces_access_key" {
  description = "DigitalOcean Spaces Access Key"
  type        = string
  sensitive   = true
}

variable "do_spaces_secret_key" {
  description = "DigitalOcean Spaces Secret Key"
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