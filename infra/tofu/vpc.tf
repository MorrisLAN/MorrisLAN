resource "vultr_vpc2" "uk_lon_1_prod" {
  description   = "uk-lon-1-prod cluster vpc"
  region        = "lhr"
  ip_block      = "10.1.270.0"
  prefix_length = 24
}
