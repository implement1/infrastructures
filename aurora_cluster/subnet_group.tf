resource "aws_db_subnet_group" "default" {
  name        = local.name_prefix
  description = "${var.environment} aurora cluster subnet group"

  subnet_ids = var.vpc_db_subnets

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = local.name_prefix
    Owner       = var.owner
  }

  provider = aws.default
}
