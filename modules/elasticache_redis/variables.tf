# naming and tags
variable "aws_region" {
  type        = string
  description = "aws region to deploy to"
  default     = "us-east-1"
}

variable "application" {
  type        = string
  description = "naming resources and tagging"
  default     = "elasticache"
}

variable "component" {
  type        = string
  description = "naming resources and tagging"
  default     = "redis"
}

variable "environment" {
  type        = string
  description = "naming resources and tagging"
  default     = "staging" 
}

variable "owner" {
  type        = string
  description = "used for tagging reources"
  default     = "DATAPLATS"
}

# kms
variable "default_kms_key_arn" {
  type        = string
  description = "the kms key arn to use for encrypting elastcache at rest"
  default     = "arn:aws:kms:us-east-1:750399893116:key/349efed1-dbd4-4118-846d-d80028b09609"
}

# parameter group
variable "parameter_group_family" {
  type        = string
  description = "the family to use for the parameter group"
}

# redis
variable "redis_apply_immediately" {
  type        = bool
  description = "apply changes immediately to redis cluster"
  default     = false
}

variable "redis_instance_type" {
  type        = string
  description = "the redis instance type to use"
  default     = "cache.t2.small" 
}

variable "redis_engine_version" {
  type        = string
  description = "the redis engine version to use on the redis instances"
  default     = "5.0"
}

variable "redis_port" {
  type        = number
  description = "the port to use on the redis cluster"
  default     = 6379
}

variable "redis_number_cache_clusters" {
  type        = number
  description = "number of cache clusters (primary and replicas) this replication group will have"
}

variable "redis_num_node_groups" {
  type        = number
  description = "number of node groups for redis cluster mode"
  default     = 1
}

variable "redis_automatic_failover_enabled" {
  type        = bool
  description = "allow redis to automatically fail over when there are issues. must be at least two replicas"
  default     = true
}

variable "redis_enable_encrypted_transit" {
  type        = bool
  description = "whether to enable encryption in transit"
  default     = true
}

variable "redis_maintenance_window" {
  type        = string
  description = "the window for performing maintenance"
  default     = "fri:03:00-fri:04:00"
}

variable "redis_snapshot_window" {
  type        = string
  description = "the window to perform snapshots"
  default     = "01:00-02:00"
}

variable "redis_snapshot_retention_days" {
  type        = number
  description = "number of days to keep snapshots"
  default     = 0
}

# sns
variable "sns_topic_critical_arn" {
  type        = string
  description = "critical sns topic"
  default     = "arn:aws:sns:us-east-1:750399893116:testtopic"
}

variable "sns_topic_non_critical_arn" {
  type        = string
  description = "critical sns topic"
  default     = "arn:aws:sns:us-east-1:750399893116:testtopic"
}

# vpc
variable "vpc_id" {
  type        = string
  description = "the vpc id for resources to live"
  default     = "vpc-046e973999e18e390"
}

variable "vpc_db_subnet_ids" {
  type        = list(string)
  description = "list of subnet ids to place database cluster"
 default     = [subnet-048f319087a37b8bc]
}