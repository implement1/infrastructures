resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-public"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_route" "public_to_igw" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gw.id

  depends_on = [
    aws_route_table.public
  ]

  provider = aws.default
}

resource "aws_route_table_association" "public" {
  count = length(var.availability_zones)

  subnet_id      = aws_subnet.public_subnets.*.id[count.index]
  route_table_id = aws_route_table.public.id

  provider = aws.default
}
