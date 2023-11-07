/* 
Variables managed by Terraform Cloud:
cloudflare_account_id
cloudflare_zone_id
cloudflare_token
github_client_id
github_client_secret
access_tunnel_clancy_password 
*/

access_app_status_policy = [
  {
    email = [],
    github = {
      name = "MorrisLAN",
      identity_provider_id = cloudflare_access_identity_provider.github.id
    }
  }
]

access_app_ha_policy = [
  {
    email = [],
    github = {
      name = "MorrisLAN",
      identity_provider_id = cloudflare_access_identity_provider.github.id
    }
  }
]

access_app_unifi_policy = [
  {
    email = [],
    github = {
      name = "MorrisLAN",
      identity_provider_id = cloudflare_access_identity_provider.github.id
    }
  }
]

access_app_clancyadmin_policy = [
  {
    email = [],
    github = {
      name = "MorrisLAN",
      identity_provider_id = cloudflare_access_identity_provider.github.id
    }
  }
]

access_app_homeradmin_policy = [
  {
    email = [],
    github = {
      name = "MorrisLAN",
      identity_provider_id = cloudflare_access_identity_provider.github.id
    }
  }
]
