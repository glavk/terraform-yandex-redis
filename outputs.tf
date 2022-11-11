output "fqdn" {
  value = yandex_mdb_redis_cluster.this.host[*].fqdn
}

output "shard_name" {
  value = yandex_mdb_redis_cluster.this.host[*].shard_name
}

output "health" {
  value = yandex_mdb_redis_cluster.this.health
}

output "status" {
  value = yandex_mdb_redis_cluster.this.status
}