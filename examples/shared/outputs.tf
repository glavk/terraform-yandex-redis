output "status" {
  value = module.sharded_zone.status
}

output "shards" {
  value = module.sharded_zone.shard_name
}

output "hosts" {
  value = module.sharded_zone.fqdn
}