resource "aws_network_acl" "db" {
  vpc_id = aws_vpc.main.id

  subnet_ids = [
    for subnet in aws_subnet.db_subnets :
    subnet.id
  ]

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-db"
    Owner       = var.owner
  }

  provider = aws.default
}

##########
## INGRESS
##########

# Allows postgres traffic from app subnet tier
resource "aws_network_acl_rule" "app_to_db_mysql_ingress_allow" {
  network_acl_id = aws_network_acl.db.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = local.app_subnets_cidr_block
  from_port      = 5432
  to_port        = 5432

  provider = aws.default
}

# Allows redis traffic from app subnet tier
resource "aws_network_acl_rule" "app_to_db_redis_ingress_allow" {
  network_acl_id = aws_network_acl.db.id
  rule_number    = 200
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = local.app_subnets_cidr_block
  from_port      = 6379
  to_port        = 6379

  provider = aws.default
}

##########
## EGRESS
##########

# Return ephemeral ports to VPC
resource "aws_network_acl_rule" "db_to_vpc_ephemeral_egress" {
  network_acl_id = aws_network_acl.db.id
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = local.app_subnets_cidr_block
  from_port      = 1024
  to_port        = 65535

  provider = aws.default
}
