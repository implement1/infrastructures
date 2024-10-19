locals {
  subnet_tier_cidrs         = cidrsubnets(var.vpc_cidr_block, var.subnet_tier_cidrs_newbits, var.subnet_tier_cidrs_newbits, var.subnet_tier_cidrs_newbits)
  public_subnets_cidr_block = local.subnet_tier_cidrs[0]
  app_subnets_cidr_block    = local.subnet_tier_cidrs[1]
  db_subnets_cidr_block     = local.subnet_tier_cidrs[2]
}

resource "aws_subnet" "public_subnets" {
  count = length(var.availability_zones)

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(local.public_subnets_cidr_block, var.public_subnets_cidr_newbits, count.index)
  availability_zone = element(var.availability_zones, count.index)

  map_public_ip_on_launch = true

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-public-${element(var.availability_zones, count.index)}"
    Owner       = var.owner
  }

  provider = aws.default
}

output "public_subnets_cidr_block" {
  value = local.public_subnets_cidr_block
}

output "public_subnets_ids" {
  value = aws_subnet.public_subnets.*.id
}

resource "aws_subnet" "app_subnets" {
  count = length(var.availability_zones)

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(local.app_subnets_cidr_block, var.app_subnets_cidr_newbits, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-app-${element(var.availability_zones, count.index)}"
    Owner       = var.owner
  }

  provider = aws.default
}

output "app_subnets_cidr_block" {
  value = local.app_subnets_cidr_block
}

output "app_subnets_ids" {
  value = aws_subnet.app_subnets.*.id
}

resource "aws_subnet" "db_subnets" {
  count = length(var.availability_zones)

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(local.db_subnets_cidr_block, var.db_subnets_cidr_newbits, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-db-${element(var.availability_zones, count.index)}"
    Owner       = var.owner
  }

  provider = aws.default
}

output "db_subnets_cidr_block" {
  value = local.db_subnets_cidr_block
}

output "db_subnets_ids" {
  value = aws_subnet.db_subnets.*.id
}
