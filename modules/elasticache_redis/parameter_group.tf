resource "aws_elasticache_parameter_group" "default" {
  name        = local.name_prefix
  description = "the parameter group for ${var.environment}"

  family = "redis5.0"

  parameter {
    name  = "cluster-enabled"
    value = "yes"
  }

  provider = aws.default
}
