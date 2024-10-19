resource "aws_route_table" "db" {
  vpc_id = aws_vpc.main.id

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-db"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_route_table_association" "db" {
  count = length(var.availability_zones)

  subnet_id      = aws_subnet.db_subnets.*.id[count.index]
  route_table_id = aws_route_table.db.id

  provider = aws.default
}
