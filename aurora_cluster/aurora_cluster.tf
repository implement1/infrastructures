resource "aws_rds_cluster" "default" {
  cluster_identifier        = local.name_prefix
  final_snapshot_identifier = local.name_prefix
  copy_tags_to_snapshot     = var.aurora_copy_tags_to_snapshot

  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.default.id

  apply_immediately   = var.aurora_apply_immediately
  deletion_protection = var.aurora_deletion_protection

  storage_encrypted = var.aurora_storage_encrypted
  kms_key_id        = aws_kms_alias.aurora_default.target_key_arn

  engine         = var.aurora_engine
  engine_version = var.aurora_engine_version

  database_name   = var.aurora_default_database_name
  port            = var.aurora_default_port
  master_username = var.aurora_admin_username
  master_password = random_password.password.result

  iam_database_authentication_enabled = var.aurora_iam_database_authentication_enabled

  availability_zones   = var.vpc_db_availability_zones
  db_subnet_group_name = aws_db_subnet_group.default.name

  vpc_security_group_ids = [aws_security_group.server.id]

  backup_retention_period      = var.aurora_backup_retention_period
  preferred_backup_window      = var.aurora_backup_window
  preferred_maintenance_window = var.aurora_maintenance_window

  enabled_cloudwatch_logs_exports = var.aurora_enabled_cloudwatch_logs_exports

  tags = {
    Application = var.application
    Backup      = var.backup
    Component   = var.component
    Environment = var.environment
    Name        = local.name_prefix
    Owner       = var.owner
  }

  provider = aws.default
}
