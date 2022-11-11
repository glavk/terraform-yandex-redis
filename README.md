# Yandex.Cloud Redis cluster module

Terraform module which creates [managed Redis cluster](https://cloud.yandex.com/services/managed-redis) on [Yandex.Cloud](https://cloud.yandex.ru/).

## Examples

### Cache without persistence

A simple Redis cluster for cache with key eviction and no key sync to disk.

```terraform
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

module "cache" {
  source  = "glavk/redis/yandex"
  version = "0.1.0"

  name        = "cache"
  description = "Cache in-memory without sync to disk"

  network_id = data.yandex_vpc_network.private.id

  persistence_mode = "OFF"
  password         = "secretpassword"
  # default policy is NOEVICTION
  maxmemory_policy = "ALLKEYS_LRU"

  hosts = {
    host1 = {
      zone      = local.zone
      subnet_id = data.yandex_vpc_subnet.private.id
    }
  }

  zone = local.zone
}
```

### Sharded one zone cluster

A simple sharded Redis cluster with key eviction and key sync to disk in one zone.

```terraform
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
  version = "0.1.0"

  name        = "sharded_cluster"
  description = "Sharded zonal cluster"

  network_id = data.yandex_vpc_network.private.id

  sharded          = true
  password         = "secretpassword"
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
```
