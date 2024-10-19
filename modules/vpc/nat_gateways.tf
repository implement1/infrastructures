output "nat_ip_addresses" {
  value = aws_eip.nat_eip.*.public_ip
}

resource "aws_eip" "nat_eip" {
  count = length(var.availability_zones)

  vpc = true


  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-nat-${element(var.availability_zones, count.index)}"
    Owner       = var.owner
  }

  depends_on = [
    aws_internet_gateway.internet_gw
  ]

  provider = aws.default
}

resource "aws_nat_gateway" "public_subnet_gateways" {
  count = length(var.availability_zones)

  allocation_id = aws_eip.nat_eip.*.id[count.index]
  subnet_id     = aws_subnet.public_subnets.*.id[count.index]

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-${element(var.availability_zones, count.index)}"
    Owner       = var.owner
  }

  depends_on = [
    aws_internet_gateway.internet_gw
  ]

  provider = aws.default
}
