resource "aws_ssm_parameter" "aurora_write_endpoint" {
  name = "/${var.environment}/aurora/write_endpoint"
  type = "SecureString"

  value     = aws_rds_cluster.default.endpoint
  overwrite = true

  key_id = aws_kms_alias.aurora_default.target_key_id

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "/${var.environment}/aurora/write_endpoint"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_ssm_parameter" "aurora_read_endpoint" {
  name = "/${var.environment}/aurora/read_endpoint"
  type = "SecureString"

  value     = aws_rds_cluster.default.reader_endpoint
  overwrite = true

  key_id = aws_kms_alias.aurora_default.target_key_id

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "/${var.environment}/aurora/read_endpoint"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_ssm_parameter" "aurora_db_port" {
  name = "/${var.environment}/aurora/port"
  type = "SecureString"

  value     = var.aurora_default_port
  overwrite = true

  key_id = aws_kms_alias.aurora_default.target_key_id

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "/${var.environment}/aurora/port"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_ssm_parameter" "aurora_client_security_group" {
  name = "/${var.environment}/aurora/client_security_group"
  type = "SecureString"

  value     = aws_security_group.client.id
  overwrite = true

  key_id = aws_kms_alias.aurora_default.target_key_id

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "/${var.environment}/aurora/client_security_group"
    Owner       = var.owner
  }

  provider = aws.default
}
