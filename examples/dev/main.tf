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

module "dev" {
  source  = "glavk/redis/yandex"
  version = "0.1.0"

  name        = "dev"
  description = "Cache (dev) in-memory without sync to disk"

  network_id = data.yandex_vpc_network.private.id

  resource_preset_id = "b3-c1-m4"
  environment        = "PRESTABLE"
  persistence_mode   = "OFF"
  password           = "secretpassword"

  hosts = {
    host1 = {
      zone      = local.zone
      subnet_id = data.yandex_vpc_subnet.private.id
    }
  }

  zone = local.zone
}