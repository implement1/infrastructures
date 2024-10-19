resource "random_password" "password" {
  count  = var.redis_enable_encrypted_transit ? 1 : 0
  length = 32

  lower     = true
  min_lower = 3

  number      = true
  min_numeric = 3

  upper     = true
  min_upper = 3

  special          = true
  min_special      = 3
  override_special = "!^-'"
}

resource "aws_secretsmanager_secret" "default" {
  count = var.redis_enable_encrypted_transit ? 1 : 0

  name        = local.name_prefix
  description = "password for elasticache redis"

  kms_key_id = var.default_kms_key_arn

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = local.name_prefix
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_secretsmanager_secret_version" "default" {
  count = var.redis_enable_encrypted_transit ? 1 : 0

  secret_id = aws_secretsmanager_secret.default[0].id
  secret_string = jsonencode(
    {
      password = random_password.password[0].result,
    }
  )

  provider = aws.default
}

