resource "aws_network_acl" "public" {
  vpc_id = aws_vpc.main.id

  subnet_ids = [
    for subnet in aws_subnet.public_subnets :
    subnet.id
  ]

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-public"
    Owner       = var.owner
  }

  provider = aws.default
}

##########
## INGRESS
##########

# Allow http traffic into public subnet
resource "aws_network_acl_rule" "public_http_ingress_allow" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80

  provider = aws.default
}

# Allow https traffic into public subnet
resource "aws_network_acl_rule" "public_https_ingress_allow" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 200
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443

  provider = aws.default
}

# Allow https traffic into public subnet
resource "aws_network_acl_rule" "public_ssh_ingress_allow" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 300
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 22
  to_port        = 22

  provider = aws.default
}

# Allow return ephemeral traffic from public subnet
resource "aws_network_acl_rule" "ephemeral_to_public_ingress_allow" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 400
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

# Allow outbound http traffic from public subnet to everywhere
# Since NAT gateways are in this subnet tier, it's needed
resource "aws_network_acl_rule" "public_ipv4_http_egress_allow" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80

  provider = aws.default
}

# Allow outbound https traffic from public subnet to everywhere
# Since NAT gateways are in this subnet tier, it's needed
resource "aws_network_acl_rule" "public_ipv4_https_egress_allow" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 200
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443

  provider = aws.default
}

# So app tier can use outbound ssh
resource "aws_network_acl_rule" "public_to_ssh_allow" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 300
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 22
  to_port        = 22

  provider = aws.default
}

# Allow ephemeral outbound traffic from public subnet
resource "aws_network_acl_rule" "ephemeral_public_egress_allow" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 400
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535

  provider = aws.default
}
