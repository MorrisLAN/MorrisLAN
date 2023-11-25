terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

provider "cloudflare" {
  api_token = ${{ secrets.CLOUDFLARE_TOKEN }}
}

module "cloudflare-zerotrust" {
  source                          = "./cloudflare-zerotrust"
  cloudflare_token                = ${{ secrets.CLOUDFLARE_TOKEN }}
  cloudflare_account_id           = ${{ secrets.CLOUDFLARE_ACCOUNT_ID }}
  access_tunnel_clancy_password   = ${{ secrets.ACCESS_TUNNEL_CLANCY_PASSWORD }}
  github_client_id     = ${{ secrets.GH_CLIENT_ID }}
  github_client_secret = ${{ secrets.CH_CLIENT_SECRET }}
  cloudflare_zone_id              = ${{ env.CLOUDFLARE_ZONE_ID }}
}
