variable "name" {
  description = "Name of the Redis cluster"
  type        = string
}

variable "network_id" {
  description = "ID of the network, to which the Redis cluster belongs"
  type        = string
}

variable "environment" {
  description = "Deployment environment of the Redis cluster. Can be either PRESTABLE or PRODUCTION"
  type        = string
  default     = "PRODUCTION"

  validation {
    condition     = contains(["PRODUCTION", "PRESTABLE"], var.environment)
    error_message = "environment should be one of `PRODUCTION` or `PRESTABLE`"
  }
}

variable "description" {
  description = "Description of the Redis cluster"
  type        = string
  default     = "Redis cluster"
}

variable "folder_id" {
  description = "The ID of the folder that the resource belongs to. If it is not provided, the default provider folder is used"
  type        = string
  default     = null
}

variable "labels" {
  description = "A set of key/value label pairs to assign to the Redis cluster"
  type        = set(string)
  default     = null
}

variable "sharded" {
  description = "Redis Cluster mode enabled/disabled"
  type        = bool
  default     = false
}

variable "tls_enabled" {
  description = "TLS support mode enabled/disabled"
  type        = bool
  default     = false
}

variable "persistence_mode" {
  description = "Persistence mode. Must be one of OFF or ON"
  type        = string
  default     = "ON"

  validation {
    condition     = contains(["ON", "OFF"], var.persistence_mode)
    error_message = "persistence_mode should be one of `ON` or `OFF`"
  }
}

variable "security_group_ids" {
  description = "A set of ids of security groups assigned to hosts of the cluster"
  type        = list(string)
  default     = []
}

variable "deletion_protection" {
  description = "Inhibits deletion of the cluster"
  type        = bool
  default     = false
}

variable "password" {
  description = "Password for the Redis cluster"
  type        = string
  sensitive   = true
}

variable "timeout" {
  description = "Close the connection after a client is idle for N seconds"
  type        = number
  default     = 0
}

variable "maxmemory_policy" {
  description = "Redis key eviction policy for a dataset that reaches maximum memory. See https://docs.redis.com/latest/rs/databases/memory-performance/eviction-policy/"
  type        = string
  default     = "NOEVICTION"

  validation {
    condition = contains([
      "VOLATILE_LRU",
      "ALLKEYS_LRU",
      "VOLATILE_LFU",
      "VOLATILE_RANDOM",
      "NOEVICTION",
      "MAXMEMORY_POLICY_UNSPECIFIED",
      "ALLKEYS_LFU",
      "ALLKEYS_RANDOM",
      "VOLATILE_TTL"
    ], var.maxmemory_policy)
    error_message = "maxmemory_policy should be one of `VOLATILE_LRU`, `ALLKEYS_LRU`, `VOLATILE_LFU`, `VOLATILE_RANDOM`, `NOEVICTION`, `MAXMEMORY_POLICY_UNSPECIFIED`, `ALLKEYS_LFU`, `ALLKEYS_RANDOM`, `VOLATILE_TTL`."
  }
}

variable "notify_keyspace_events" {
  description = "Select the events that Redis will notify among a set of classes"
  type        = string
  default     = ""
}

variable "slowlog_log_slower_than" {
  description = "Log slow queries below this number in microseconds"
  type        = number
  default     = 10000
}

variable "slowlog_max_len" {
  description = "Slow queries log length"
  type        = number
  default     = 1000
}

variable "databases" {
  description = "Number of databases (changing requires redis-server restart)"
  type        = number
  default     = 16
}

variable "redis_version" {
  description = "Version of Redis"
  type        = string
  default     = "6.2"
}

variable "client_output_buffer_limit_normal" {
  description = "Normal clients output buffer limits (bytes)"
  type        = string
  default     = "60 536870912 1073741824"
}

variable "client_output_buffer_limit_pubsub" {
  description = "Pubsub clients output buffer limits (bytes)"
  type        = string
  default     = "60 536870912 1073741824"
}

// https://cloud.yandex.com/en/docs/managed-redis/concepts/instance-types
variable "resource_preset_id" {
  description = "The ID of the preset for computational resources available to a host (CPU, memory etc.)"
  type        = string
  default     = "hm3-c2-m8"
}

variable "disk_size" {
  description = "Volume of the storage available to a host, in gigabytes"
  type        = number
  default     = 16
}

variable "disk_type_id" {
  description = "Type of the storage of Redis hosts - environment default is used if missing"
  type        = string
  default     = "network-ssd"

  validation {
    condition     = contains(["network-ssd", "local-ssd", "network-ssd-nonreplicated"], var.disk_type_id)
    error_message = "disk_type_id be one of `network-ssd`, `local-ssd`, `network-ssd-nonreplicated`"
  }
}

variable "zone" {
  description = "The availability zone where the Redis host will be created. See https://cloud.yandex.com/en/docs/overview/concepts/geo-scope"
  type        = string

  validation {
    condition     = contains(["ru-central1-a", "ru-central1-b", "ru-central1-c"], var.zone)
    error_message = "zone must be one of `ru-central1-a`, `ru-central1-b`, `ru-central1-c` (with limitations)"
  }
}

variable "subnet_id" {
  description = "The ID of the subnet, to which the host belongs. The subnet must be a part of the network to which the cluster belongs"
  type        = string
  default     = null
}

#variable "shard_name" {
#  description = "The name of the shard to which the host belongs"
#  type        = string
#  default     = "shard1"
#}

variable "replica_priority" {
  description = "Replica priority of a current replica (usable for non-sharded only)"
  type        = any
  default     = null
}

variable "assign_public_ip" {
  description = "Sets whether the host should get a public IP address or not"
  type        = bool
  default     = false
}

variable "type" {
  description = "Type of maintenance window. Can be either ANYTIME or WEEKLY. A day and hour of window need to be specified with weekly window"
  type        = string
  default     = "ANYTIME"

  validation {
    condition     = contains(["ANYTIME", "WEEKLY"], var.type)
    error_message = "type must be one of `ANYTIME`, `WEEKLY`"
  }
}

variable "hour" {
  description = "Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly"
  type        = number
  default     = 24
}

variable "day" {
  description = "Day of week for maintenance window if window type is weekly"
  type        = string
  default     = "MON"

  validation {
    condition     = contains(["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"], var.day)
    error_message = "day must be one of `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`"
  }
}

variable "hosts" {
  description = "Redis hosts definition"
  type = map(object({
    zone      = string
    subnet_id = string
  }))

  default = {
    host1 = {
      zone      = "ru-central1-a",
      subnet_id = ""
    },
    host2 = {
      zone      = "ru-central1-a",
      subnet_id = ""
    }
  }
}