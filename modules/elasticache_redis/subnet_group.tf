resource "aws_elasticache_subnet_group" "default" {
  name        = local.name_prefix
  description = "subnet group for ${var.environment} redis"

  subnet_ids = var.vpc_db_subnet_ids

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = local.name_prefix
    Owner       = var.owner
  }

  provider = aws.default
}
