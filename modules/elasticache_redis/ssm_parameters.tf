resource "aws_ssm_parameter" "elasticache_primary_endpoint" {
  name = "/${var.environment}/elasticache/primary_endpoint"
  type = "SecureString"

  value     = aws_elasticache_replication_group.default.configuration_endpoint_address
  overwrite = true

  key_id = var.default_kms_key_arn

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "/${var.environment}/elasticache/primary_endpoint"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_ssm_parameter" "elasticache_port" {
  name = "/${var.environment}/elasticache/port"
  type = "SecureString"

  value     = var.redis_port
  overwrite = true

  key_id = var.default_kms_key_arn

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "/${var.environment}/elasticache/port"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_ssm_parameter" "elasticache_password" {
  name = "/${var.environment}/elasticache/password"
  type = "SecureString"

  value     = random_password.password[0].result
  overwrite = true

  key_id = var.default_kms_key_arn

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "/${var.environment}/elasticache/password"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_ssm_parameter" "elasticache_client_security_group" {
  name = "/${var.environment}/elasticache/security_groups/client"
  type = "SecureString"

  value     = aws_security_group.client.id
  overwrite = true

  key_id = var.default_kms_key_arn

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "/${var.environment}/elasticache/security_groups/client"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_ssm_parameter" "elasticache_server_security_group" {
  name = "/${var.environment}/elasticache/security_groups/server"
  type = "SecureString"

  value     = aws_security_group.server.id
  overwrite = true

  key_id = var.default_kms_key_arn

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "/${var.environment}/elasticache/security_groups/server"
    Owner       = var.owner
  }

  provider = aws.default
}
