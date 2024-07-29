variable "cloudflare_token" {
  description = "Cloudflare API Token"
  type        = string
  sensitive   = true
}

variable "digitalocean_token" {
  description = "DigitalOcean API Token"
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

variable "digitalocean_ssh_key" {
  description = "SSH key used to access DigitalOcean Droplets"
  default     = "b3:57:07:56:0f:8b:88:eb:43:cd:f1:d7:38:59:a3:b5"
}