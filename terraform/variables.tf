# Values set by Terraform Cloud
variable "cloudflare_account_id" { sensitive = true }
variable "cloudflare_token" { sensitive = true }
variable "cloudflare_github_client_id" { sensitive = true }
variable "cloudflare_github_client_secret" { sensitive = true }
variable "cloudflare_clancy_secret" { sensitive = true }
variable "cloudflare_zone_id" {}
variable "allow_home_assistant_list" { type = list(object({ email = list(string), github = map(string) })) }