resource "aws_rds_cluster_instance" "cluster_instances" {
  count = var.aurora_instance_count

  cluster_identifier = aws_rds_cluster.default.id
  identifier         = "${local.name_prefix}-${count.index}"
  engine             = var.aurora_engine
  ca_cert_identifier = var.aurora_ca_cert_identifier

  instance_class        = var.aurora_instance_class
  copy_tags_to_snapshot = var.aurora_copy_tags_to_snapshot

  apply_immediately          = var.aurora_apply_immediately
  auto_minor_version_upgrade = var.aurora_auto_minor_version_upgrade

  publicly_accessible = var.aurora_publicly_accessible

  tags = {
    Application = var.application
    Backup      = var.backup
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-${count.index}"
    Owner       = var.owner
  }

  provider = aws.default
}
