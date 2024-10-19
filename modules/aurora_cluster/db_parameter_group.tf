resource "aws_rds_cluster_parameter_group" "default" {
  name        = local.name_prefix
  description = "parameter group for ${local.name_prefix}"

  family = var.aurora_parameter_group_family_name

  parameter {
    name  = "log_min_duration_statement"
    value = var.aurora_parameter_group_log_min_duration_statement
  }

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = local.name_prefix
    Owner       = var.owner
  }

  provider = aws.default
}
