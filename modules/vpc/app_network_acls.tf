resource "aws_network_acl" "app" {
  vpc_id = aws_vpc.main.id

  subnet_ids = [
    for subnet in aws_subnet.app_subnets :
    subnet.id
  ]

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-app"
    Owner       = var.owner
  }

  provider = aws.default
}

##########
## INGRESS
##########

# Allow http traffic coming in from vpc
resource "aws_network_acl_rule" "vpc_to_app_http_ingress_allow" {
  network_acl_id = aws_network_acl.app.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.vpc_cidr_block
  from_port      = 80
  to_port        = 80

  provider = aws.default
}

# Allow https traffic coming in from vpc
resource "aws_network_acl_rule" "vpc_to_app_https_ingress_allow" {
  network_acl_id = aws_network_acl.app.id
  rule_number    = 200
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.vpc_cidr_block
  from_port      = 443
  to_port        = 443

  provider = aws.default
}

# So traffic can return back to the subnet
resource "aws_network_acl_rule" "all_to_app_ephemeral_egress_allow" {
  network_acl_id = aws_network_acl.app.id
  rule_number    = 300
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535

  provider = aws.default
}

##########
## EGRESS
##########

# Allow http outbound traffic
resource "aws_network_acl_rule" "app_to_all_http_egress_allow" {
  network_acl_id = aws_network_acl.app.id
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80

  provider = aws.default
}

# Allow https outbound traffic
resource "aws_network_acl_rule" "app_to_all_https_egress_allow" {
  network_acl_id = aws_network_acl.app.id
  rule_number    = 200
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443

  provider = aws.default
}

# So app tier can use postgres to db tier
resource "aws_network_acl_rule" "app_to_db_postgres_egress_allow" {
  network_acl_id = aws_network_acl.app.id
  rule_number    = 300
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = local.db_subnets_cidr_block
  from_port      = 5432
  to_port        = 5432

  provider = aws.default
}

# Sp app tier can use redis
resource "aws_network_acl_rule" "app_to_redis_egress_allow" {
  network_acl_id = aws_network_acl.app.id
  rule_number    = 400
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = local.db_subnets_cidr_block
  from_port      = 6379
  to_port        = 6379

  provider = aws.default
}

# So app tier can use sqs
resource "aws_network_acl_rule" "app_to_sqs_allow" {
  network_acl_id = aws_network_acl.app.id
  rule_number    = 500
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 9324
  to_port        = 9324

  provider = aws.default
}

# So app tier can use outbound ssh
resource "aws_network_acl_rule" "app_to_ssh_allow" {
  network_acl_id = aws_network_acl.app.id
  rule_number    = 600
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 22
  to_port        = 22

  provider = aws.default
}

# So traffic can happen when coming into app tier
resource "aws_network_acl_rule" "app_to_all_ephemeral_egress_allow" {
  network_acl_id = aws_network_acl.app.id
  rule_number    = 700
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535

  provider = aws.default
}
