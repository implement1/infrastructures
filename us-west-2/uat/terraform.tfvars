# naming and tags
environment = "uat"

# vpc
vpc_cidr_block = "10.1.0.0/16"

# acm
hosted_zone_domain_name = "redis7.x"

# aurora
aurora_instance_count              = 1
aurora_instance_class              = "db.t3.medium"
aurora_engine                      = "aurora-postgresql"
aurora_engine_version              = "12.4"
aurora_parameter_group_family_name = "aurora-postgresql12"
aurora_maintenance_window          = "Sat:01:00-Sat:03:00"
aurora_backup_window               = "03:01-04:01"
aurora_backup_retention_period     = 3
# set memory in MB. It will be converted to bytes
aurora_freeable_memory_threshold_non_critical = 2000
aurora_freeable_memory_threshold_critical     = 1000
aurora_cpu_utilization_threshold_non_critical = 85
aurora_cpu_utilization_threshold_critical     = 95
# slow query logs
aurora_parameter_group_log_min_duration_statement = 15000
aurora_enabled_cloudwatch_logs_exports            = ["postgresql"]

# cloudwatch
cw_log_group_default_retention_in_days = 3

# elasticache redis
elasticache_redis_instance_type              = "cache.t3.small"
elasticache_redis_engine_version             = "7.0.6"
elasticache_parameter_group_family           = "redis5.x"
elasticache_redis_num_node_groups            = 1
elasticache_redis_number_cache_clusters      = 3
elasticache_redis_automatic_failover_enabled = true
elasticache_redis_snapshot_retention_days    = 0

# elasticsearch
elasticsearch_instance_count  = 2
elasticsearch_instance_size   = "r4.large.elasticsearch"
elasticsearch_ebs_enabled     = true
elasticsearch_ebs_volume_size = 50
elasticsearch_ebs_volume_type = "gp2"
elasticsearch_advanced_options = {
  "rest.action.multi.allow_explicit_index" = "true",
}

# sns
enable_slack_lambda_non_critical_notifications = false
enable_slack_lambda_critical_notifications     = false