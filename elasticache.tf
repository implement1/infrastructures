module "elasticache_redis" {
  source = "./modules/elasticache_redis"

  # tags and # naming
  aws_region  = var.aws_region
  environment = var.environment
  owner       = var.owner

  # update this when app is updated
  redis_enable_encrypted_transit = true

  default_kms_key_arn = aws_kms_alias.default.target_key_arn

  redis_instance_type         = var.elasticache_redis_instance_type
  redis_num_node_groups       = var.elasticache_redis_num_node_groups
  redis_number_cache_clusters = var.elasticache_redis_number_cache_clusters

  redis_engine_version   = var.elasticache_redis_engine_version
  parameter_group_family = var.elasticache_parameter_group_family

  redis_automatic_failover_enabled = var.elasticache_redis_automatic_failover_enabled

  redis_snapshot_retention_days = var.elasticache_redis_snapshot_retention_days

  # sns
#  sns_topic_non_critical_arn = module.sns_topics.sns_topic_non_critical_arn
#  sns_topic_critical_arn     = module.sns_topics.sns_topic_critical_arn

  # vpc settings
  vpc_id            = "vpc-046e973999e18e390"
#  vpc_id            = module.vpc.vpc_id
  vpc_db_subnet_ids = module.vpc.db_subnets_ids

  providers = {
    aws.default = aws.default
  }
}

output "elasticache_redis_client_security_group" {
  value = module.elasticache_redis.client_security_group
}

output "elasticache_redis_server_security_group" {
  value = module.elasticache_redis.server_security_group
}

output "elasticache_redis_id" {
  value = module.elasticache_redis.elasticache_id
}

output "elasticache_redis_arn" {
  value = module.elasticache_redis.elasticache_arn
}

output "elasticache_redis_primary_endpoint_address" {
  value = module.elasticache_redis.primary_endpoint_address
}

output "elasticache_redis_reader_endpoint_address" {
  value = module.elasticache_redis.elasticache_id
}
