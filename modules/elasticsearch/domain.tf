resource "aws_elasticsearch_domain" "default" {
  domain_name = local.name_prefix

  elasticsearch_version = var.elasticsearch_version

  access_policies = var.elasticsearch_access_policies

  cluster_config {
    instance_type  = var.elasticsearch_instance_size
    instance_count = var.elasticsearch_instance_count

    zone_awareness_enabled = var.elasticsearch_instance_count >= 2 ? true : false
    zone_awareness_config {
      availability_zone_count = var.elasticsearch_instance_count >= 2 ? var.elasticsearch_instance_count : null
    }
  }

  ebs_options {
    ebs_enabled = var.elasticsearch_ebs_enabled
    volume_size = var.elasticsearch_ebs_volume_size
    volume_type = var.elasticsearch_ebs_volume_type
  }

  encrypt_at_rest {
    enabled    = true
    kms_key_id = var.kms_key_arn
  }
  node_to_node_encryption {
    enabled = true
  }

  snapshot_options {
    automated_snapshot_start_hour = var.elasticsearch_automated_snapshot_start_hour
  }

  dynamic "log_publishing_options" {
    for_each = var.elasticsearch_log_publishing_types

    content {
      enabled                  = var.elasticsearch_log_publishing_enabled
      cloudwatch_log_group_arn = element(aws_cloudwatch_log_group.default.*.arn, 0)
      log_type                 = log_publishing_options.value
    }
  }

  vpc_options {
    subnet_ids = slice(var.vpc_subnet_ids, 0, var.elasticsearch_instance_count)

    security_group_ids = [
      aws_security_group.server.id,
    ]
  }

  advanced_options = var.elasticsearch_advanced_options

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = local.name_prefix
    Owner       = var.owner
  }

  depends_on = [
    aws_iam_service_linked_role.es,
  ]

  provider = aws.default
}
