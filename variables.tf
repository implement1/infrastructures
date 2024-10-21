# naming and tags
variable "aws_region" {
  type        = string
  description = "aws region to deploy to"
  default     = "us-west-2"
}

variable "application" {
  type        = string
  description = "used for naming resources and tagging"
  default     = "infras"
}

variable "component" {
  type        = string
  description = "used for naming resources and tagging"
  default     = "infrastructure"
}

variable "environment" {
  type        = string
  description = "used for naming resources and tagging"
}

variable "owner" {
  type        = string
  description = "used for tagging reources"
  default     = "infras"
}

# acm
variable "hosted_zone_domain_name" {
  type        = string
  description = "the domain name to use for this environment. (i.e. uat.confirm.com)"
}

# aurora
variable "aurora_cluster_backup" {
  type        = bool
  description = "true is backup of aurora should be done by aws backup"
  default     = true
}

variable "aurora_instance_count" {
  type        = number
  description = "the number of instances to add to aurora cluster"
}

variable "aurora_instance_class" {
  type        = string
  description = "the instance class to use for creating rds instance(s)"
}

variable "aurora_engine" {
  type        = string
  description = "the rds engine to use for the rds instance(s)"
}

variable "aurora_engine_version" {
  type        = string
  description = "the rds engine version to use for the rds instance(s)"
}

variable "aurora_parameter_group_family_name" {
  type        = string
  description = "the family of db parameter group"
}

variable "aurora_parameter_group_log_min_duration_statement" {
  type        = number
  description = "log only statements slower than (ms)"
}

variable "aurora_enabled_cloudwatch_logs_exports" {
  type        = list(string)
  description = "Set of log types to enable for exporting to CloudWatch logs."
}

variable "aurora_maintenance_window" {
  type        = string
  description = "window to perform maintenance in"
}

variable "aurora_backup_window" {
  type        = string
  description = "daily time range (in UTC) during which automated backups are created"
}

variable "aurora_freeable_memory_threshold_non_critical" {
  type        = number
  description = "the threshold to set for non crtical alert"
}

variable "aurora_freeable_memory_threshold_critical" {
  type        = number
  description = "the threshold to set for crtical alert"
}

variable "aurora_cpu_utilization_threshold_non_critical" {
  type        = number
  description = "the threshold to set for non crtical alert"
}

variable "aurora_cpu_utilization_threshold_critical" {
  type        = number
  description = "the threshold to set for crtical alert"
}

variable "aurora_backup_retention_period" {
  type        = number
  description = "days to retain backups for [0 - 35]"
}

# backup account
variable "backup_account_id" {
  type        = number
  description = "the account number of the backup account"
  default     = XXXXXXXXXXXXXXX
}

# cloudwatch
variable "cw_log_group_default_retention_in_days" {
  type        = number
  description = "amount of days to keep cloudwatch logs"
}

# elasticache redis
variable "elasticache_redis_instance_type" {
  type        = string
  description = "the isntance type ot use for elastcache instances"
}

variable "elasticache_parameter_group_family" {
  type        = string
  description = "the family group to use for ealsticache parameter group"
  default     = "redis6.x"
}

variable "elasticache_redis_engine_version" {
  type        = string
  description = "the version of redis to use"
  default     = "6.x"
}

variable "elasticache_redis_number_cache_clusters" {
  type        = number
  description = "number of cache clusters (primary and replicas) this replication group will have"
}

variable "elasticache_redis_num_node_groups" {
  type        = number
  description = "number of node groups for redis cluster mode"
}

variable "elasticache_redis_automatic_failover_enabled" {
  type        = bool
  description = "allow redis to automatically fail over when there are issues. must be at least two replicas"
  default     = true
}

variable "elasticache_redis_snapshot_retention_days" {
  type        = number
  description = "number of days to keep snapshots of redis"
}

# elasticsearch
variable "elasticsearch_instance_count" {
  type        = number
  description = "the number of instances to add to the elasticsearch cluster"
}

variable "elasticsearch_instance_size" {
  type        = string
  description = "the instance type to use for elasticsearch"
}

variable "elasticsearch_ebs_enabled" {
  type        = bool
  description = "enable ebs on elasticsearch. Needed for some instance types"
  default     = false
}

variable "elasticsearch_ebs_volume_size" {
  type        = number
  description = "the ebs volume size to use for the ebs volume (in GiB)"
  default     = null
}

variable "elasticsearch_ebs_volume_type" {
  type        = string
  description = "the volume type to use with ebs [standard, gp2, io1]"
  default     = null
}

variable "elasticsearch_advanced_options" {
  type        = map(any)
  description = "map of options to add to elasticsearch"
}

# sns
variable "enable_slack_lambda_non_critical_notifications" {
  type        = bool
  description = "enable slack notifications from non critical notifications"
}

variable "enable_slack_lambda_critical_notifications" {
  type        = bool
  description = "enable slack notifications from non critical notifications"
}


# vpc
variable "vpc_cidr_block" {
  type        = string
  description = "the cidr block to use for the VPC"
}

variable "vpc_availability_zones" {
  type        = list(string)
  description = "the azs to add subnets"
  default = [
    "us-west-2a",
    "us-west-2b",
    "us-west-2c",
  ]
}
