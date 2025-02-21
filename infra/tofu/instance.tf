# resource "vultr_instance" "omni" {
#   hostname = "omni.morrislan.net"
#   plan     = "vc2-1c-2gb"
#   region   = "lhr"
#   os_id    = 2284
#   backups  = "enabled"
#   backups_schedule {
#     type = "daily"
#   }
# }

# resource "vultr_instance" "kmn_uk_lon_1_prod" {
#   count    = 3
#   hostname = "kmn-${count.index + 1}.prod.uk-lon-1.morrislan.net"
#   plan     = "vc2-2c-4gb"
#   region   = "lhr"
#   os_id    = 2284
#   vpc2_ids = [ vultr_vpc2.uk_lon_1_prod.id ]
#   backups  = "enabled"
#   backups_schedule {
#     type = "daily"
#   }
# }
