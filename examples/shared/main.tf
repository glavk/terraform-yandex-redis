locals {
  zone   = "ru-central1-a"
  folder = "your_folder_id"

  network_name = "private"
  subnet_name  = "private-a"
}

data "yandex_vpc_network" "private" {
  folder_id = local.folder
  name      = local.network_name
}

data "yandex_vpc_subnet" "private" {
  name = local.subnet_name
}

module "sharded_zone" {
  source  = "glavk/redis/yandex"
  version = "0.1.6"

  name        = "sharded_cluster"
  description = "Sharded zonal cluster"

  network_id = data.yandex_vpc_network.private.id

  sharded  = true
  password = "secretpassword"
  # default policy is NOEVICTION
  maxmemory_policy = "ALLKEYS_LRU"


  hosts = {
    host1 = {
      zone      = local.zone
      subnet_id = data.yandex_vpc_subnet.private.id
    }
    host2 = {
      zone      = local.zone
      subnet_id = data.yandex_vpc_subnet.private.id
    }
    host3 = {
      zone      = local.zone
      subnet_id = data.yandex_vpc_subnet.private.id
    }
  }

  zone = local.zone
}