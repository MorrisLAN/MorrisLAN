resource "cloudflare_device_dex_test" "status" {
  account_id  = var.cloudflare_account_id
  name        = "MorrisLAN Status"
  description = ""
  interval    = "0h30m0s"
  enabled     = true
  data {
    host   = "https://status.morrislan.net"
    kind   = "http"
    method = "GET"
  }
}

resource "cloudflare_device_dex_test" "ha" {
  account_id  = var.cloudflare_account_id
  name        = "Home Assistant"
  description = ""
  interval    = "0h30m0s"
  enabled     = true
  data {
    host   = "https://ha.morrislan.net"
    kind   = "http"
    method = "GET"
  }
}

resource "cloudflare_device_dex_test" "unifi" {
  account_id  = var.cloudflare_account_id
  name        = "UniFi"
  description = ""
  interval    = "0h30m0s"
  enabled     = true
  data {
    host   = "https://unifi.morrislan.net"
    kind   = "http"
    method = "GET"
  }
}