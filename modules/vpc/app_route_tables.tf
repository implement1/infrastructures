resource "aws_route_table" "app" {
  count  = length(var.availability_zones)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public_subnet_gateways.*.id[count.index]
  }

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-app-${element(var.availability_zones, count.index)}"
    Owner       = var.owner
  }

  provider = aws.default
}


resource "aws_route_table_association" "app" {
  count = length(var.availability_zones)

  subnet_id      = aws_subnet.app_subnets.*.id[count.index]
  route_table_id = aws_route_table.app.*.id[count.index]

  provider = aws.default
}
