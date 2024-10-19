resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${var.aws_region}.dynamodb"
  vpc_endpoint_type = "Gateway"

  policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "*",
      "Effect": "Allow",
      "Principal": "*",
      "Resource": "*"
    }
  ]
}
POLICY

  route_table_ids = flatten([
    aws_route_table.public.id,
    aws_route_table.db.id,
    [
      for route_table in aws_route_table.app :
      route_table.id
    ],
  ])

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-dynamodb"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"

  policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "*",
      "Effect": "Allow",
      "Principal": "*",
      "Resource": "*"
    }
  ]
}
POLICY

  route_table_ids = flatten([
    aws_route_table.public.id,
    aws_route_table.db.id,
    [
      for route_table in aws_route_table.app :
      route_table.id
    ],
  ])

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-s3"
    Owner       = var.owner
  }

  provider = aws.default
}
