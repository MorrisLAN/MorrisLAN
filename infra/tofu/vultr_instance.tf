resource "vultr_instance" "kmn_uk_lon_1_prod" {
  count    = 3
  hostname = "kmn-${count.index + 1}.prod.uk-lon-1.morrislan.net"
  plan     = "vhf-2c-2gb"
  region   = "lhr"
  os_id    = 2284
  backups  = "enabled"
  backups_schedule {
    type = "daily"
  }
}