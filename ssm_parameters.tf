resource "aws_ssm_parameter" "elasticsearch_endpoint" {
  name        = "/${var.environment}/elasticsearch/endpoint"
  description = "the elasticsearch endpoint for ${var.environment}"
  type        = "SecureString"

  value     = "https://${module.elasticsearch.elasticsearch_endpoint}:443"
  overwrite = true

  key_id = aws_kms_alias.default.target_key_id

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "/${var.environment}/elasticsearch/endpoint"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_ssm_parameter" "elasticsearch_kibana_endpoint" {
  name        = "/${var.environment}/elasticsearch/kibana/endpoint"
  description = "the elasticsearch endpoint for ${var.environment}"
  type        = "SecureString"

  value     = "https://${module.elasticsearch.kibana_endpoint}:443"
  overwrite = true

  key_id = aws_kms_alias.default.target_key_id

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "/${var.environment}/elasticsearch/kibana/endpoint"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_ssm_parameter" "elasticsearch_server_security_group" {
  name        = "/${var.environment}/elasticsearch/security_groups/server"
  description = "the elasticsearch endpoint for ${var.environment}"
  type        = "SecureString"

  value     = module.elasticsearch.server_security_group_id
  overwrite = true

  key_id = aws_kms_alias.default.target_key_id

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "/${var.environment}/elasticsearch/security_groups/server"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_ssm_parameter" "elasticsearch_client_security_group" {
  name        = "/${var.environment}/elasticsearch/security_groups/client"
  description = "the elasticsearch endpoint for ${var.environment}"
  type        = "SecureString"

  value     = module.elasticsearch.client_security_group_id
  overwrite = true

  key_id = aws_kms_alias.default.target_key_id

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "/${var.environment}/elasticsearch/security_groups/client"
    Owner       = var.owner
  }

  provider = aws.default
}
