# client
resource "aws_security_group" "client" {
  name        = "${local.name_prefix}-client"
  description = "allow only outbound traffic for rds"
  vpc_id      = var.vpc_id

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-client"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_security_group_rule" "client_rds" {
  security_group_id = aws_security_group.client.id
  description       = "allow rds access"

  type                     = "egress"
  protocol                 = "tcp"
  from_port                = var.aurora_default_port
  to_port                  = var.aurora_default_port
  source_security_group_id = aws_security_group.server.id

  provider = aws.default
}

# server
resource "aws_security_group" "server" {
  name        = "${local.name_prefix}-server"
  description = "allow only inbound traffic for rds"
  vpc_id      = var.vpc_id

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-server"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_security_group_rule" "server_rds" {
  security_group_id = aws_security_group.server.id
  description       = "allow rds client access"

  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = var.aurora_default_port
  to_port                  = var.aurora_default_port
  source_security_group_id = aws_security_group.client.id

  provider = aws.default
}
