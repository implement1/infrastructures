# naming and tags
environment = "prod"

# vpc
vpc_cidr_block = "10.2.0.0/16"

# acm
hosted_zone_domain_name = "test-domain.net"

# aurora
aurora_instance_count                         = 1
aurora_instance_class                         = "db.r5.xlarge"
aurora_engine                                 = "aurora-postgresql"
aurora_engine_version                         = "12.7"
aurora_parameter_group_family_name            = "aurora-postgresql12"
aurora_maintenance_window                     = "wed:07:47-wed:08:17"
aurora_backup_window                          = "08:32-09:02"
aurora_backup_retention_period                = 30
aurora_freeable_memory_threshold_non_critical = 5000
aurora_freeable_memory_threshold_critical     = 2500
aurora_cpu_utilization_threshold_non_critical = 85
aurora_cpu_utilization_threshold_critical     = 95
# slow queries logs
aurora_parameter_group_log_min_duration_statement = 10000
aurora_enabled_cloudwatch_logs_exports            = ["postgresql"]

# cloudwatch
cw_log_group_default_retention_in_days = 365

# elasticache redis
elasticache_redis_instance_type              = "cache.t3.medium"
elasticache_redis_engine_version             = "7.0.6"
elasticache_parameter_group_family           = "redis7.x"
elasticache_redis_num_node_groups            = 1
elasticache_redis_number_cache_clusters      = 3
elasticache_redis_automatic_failover_enabled = true
elasticache_redis_snapshot_retention_days    = 0

# elasticsearch
elasticsearch_instance_count  = 2
elasticsearch_instance_size   = "r5.large.elasticsearch"
elasticsearch_ebs_enabled     = true
elasticsearch_ebs_volume_size = 50
elasticsearch_ebs_volume_type = "gp2"
elasticsearch_advanced_options = {
  "rest.action.multi.allow_explicit_index" = "true",
  "override_main_response_version"         = "false",
}

# sns
enable_slack_lambda_non_critical_notifications = false
enable_slack_lambda_critical_notifications     = true