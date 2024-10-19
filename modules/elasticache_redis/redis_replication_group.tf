resource "aws_elasticache_replication_group" "default" {
  description = "Replication group description"
  replication_group_id          = local.name_prefix

  node_type             = var.redis_instance_type
  #number_cache_clusters = var.redis_number_cache_clusters

  engine         = "redis"
  engine_version = var.redis_engine_version

  notification_topic_arn = var.sns_topic_non_critical_arn

  parameter_group_name = aws_elasticache_parameter_group.default.name

  port = var.redis_port

  at_rest_encryption_enabled = true
  kms_key_id                 = var.default_kms_key_arn

  transit_encryption_enabled = var.redis_enable_encrypted_transit
  auth_token                 = var.redis_enable_encrypted_transit ? random_password.password[0].result : null

  automatic_failover_enabled = true

  apply_immediately          = var.redis_apply_immediately
  auto_minor_version_upgrade = true

  maintenance_window       = var.redis_maintenance_window
  snapshot_window          = var.redis_snapshot_window
  snapshot_retention_limit = var.redis_snapshot_retention_days

  final_snapshot_identifier = local.name_prefix

  subnet_group_name = aws_elasticache_subnet_group.default.name

  security_group_ids = [
    aws_security_group.server.id,
  ]

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = local.name_prefix
    Owner       = var.owner
  }

  provider = aws.default
}
