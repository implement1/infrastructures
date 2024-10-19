locals {
  # Convery MB to bytes for alarms in module
  aurora_freeable_memory_threshold_non_critical = 1048576 * var.aurora_freeable_memory_threshold_non_critical
  aurora_freeable_memory_threshold_critical     = 1048576 * var.aurora_freeable_memory_threshold_critical
}

module "aurora_cluster" {
  source = "./modules/aurora_cluster"

  # tags and # naming
  aws_region  = var.aws_region
  environment = var.environment
  owner       = var.owner

  # backup
  backup            = var.aurora_cluster_backup
  backup_account_id = var.backup_account_id

  # cloudwatch (memory should be set based on instance size and in bytes)
  freeable_memory_threshold_non_critical = local.aurora_freeable_memory_threshold_non_critical
  freeable_memory_threshold_critical     = local.aurora_freeable_memory_threshold_critical
  cpu_utilization_threshold_non_critical = var.aurora_cpu_utilization_threshold_non_critical
  cpu_utilization_threshold_critical     = var.aurora_cpu_utilization_threshold_critical

  # vpc settings
  vpc_id                    = module.vpc.vpc_id
  vpc_db_availability_zones = var.vpc_availability_zones
  vpc_db_subnets            = module.vpc.db_subnets_ids

  # aurora settings
  aurora_instance_count = var.aurora_instance_count
  aurora_instance_class = var.aurora_instance_class

  aurora_engine                                     = var.aurora_engine
  aurora_engine_version                             = var.aurora_engine_version
  aurora_parameter_group_family_name                = var.aurora_parameter_group_family_name
  aurora_parameter_group_log_min_duration_statement = var.aurora_parameter_group_log_min_duration_statement
  aurora_enabled_cloudwatch_logs_exports            = var.aurora_enabled_cloudwatch_logs_exports

  aurora_maintenance_window      = var.aurora_maintenance_window
  aurora_backup_window           = var.aurora_backup_window
  aurora_backup_retention_period = var.aurora_backup_retention_period

  sns_topic_non_critical_arn = module.sns_topics.sns_topic_non_critical_arn
  sns_topic_critical_arn     = module.sns_topics.sns_topic_critical_arn

  providers = {
    aws.default = aws.default
  }
}

output "aurora_write_endpoint" {
  value = module.aurora_cluster.aurora_write_endpoint
}

output "aurora_read_endpoint" {
  value = module.aurora_cluster.aurora_read_endpoint
}

output "aurora_server_security_group" {
  value = module.aurora_cluster.aurora_server_security_group
}

output "aurora_client_security_group" {
  value = module.aurora_cluster.aurora_client_security_group
}
