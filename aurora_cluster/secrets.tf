resource "random_password" "password" {
  length = 32

  lower     = true
  min_lower = 3

  number      = true
  min_numeric = 3

  upper     = true
  min_upper = 3

  special          = true
  min_special      = 3
  override_special = "~!#%^&*()_-+={}[]<>,.;?"
}

resource "aws_secretsmanager_secret" "default" {
  name        = local.name_prefix
  description = "password for aurora cluster"

  kms_key_id = aws_kms_alias.aurora_default.target_key_id

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
  secret_id = aws_secretsmanager_secret.default.id
  secret_string = jsonencode(
    {
      username = var.aurora_admin_username,
      password = random_password.password.result,
    }
  )

  provider = aws.default
}

