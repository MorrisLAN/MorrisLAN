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

variable "do_token" {
  description = "DigitalOcean API Token"
  type        = string
  sensitive   = true
}

variable "dovpc_tunnel_token" {
  description = "DigitalOcean VPC Cloudflare Tunnel Token"
  type        = string
  sensitive   = true
}