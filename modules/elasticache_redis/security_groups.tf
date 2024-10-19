# client
resource "aws_security_group" "client" {
  name        = "${local.name_prefix}-client"
  description = "Allow only outbound traffic for redis"
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

resource "aws_security_group_rule" "client_to_server" {
  security_group_id = aws_security_group.client.id
  description       = "allow redis server access"

  type                     = "egress"
  protocol                 = "tcp"
  from_port                = var.redis_port
  to_port                  = var.redis_port
  source_security_group_id = aws_security_group.server.id

  provider = aws.default
}

# server
resource "aws_security_group" "server" {
  name        = "${local.name_prefix}-server"
  description = "Allow only inbound traffic for redis"
  vpc_id      = var.vpc_id

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = local.name_prefix
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_security_group_rule" "server_from_client" {
  security_group_id = aws_security_group.server.id
  description       = "allow redis client access"

  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = var.redis_port
  to_port                  = var.redis_port
  source_security_group_id = aws_security_group.client.id

  provider = aws.default
}
