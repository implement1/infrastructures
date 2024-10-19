# naming
locals {
  name_prefix = lower(format("%s-%s-%s", var.environment, var.application, var.component))
}

# vpc
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = local.name_prefix
    Owner       = var.owner
  }

  provider = aws.default
}

output "vpc_id" {
  value = aws_vpc.main.id
}

resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = local.name_prefix
    Owner       = var.owner
  }

  provider = aws.default
}
