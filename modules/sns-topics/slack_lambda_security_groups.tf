resource "aws_security_group" "slack_lambda" {
  count = var.enable_slack_lambda_non_critical_notifications || var.enable_slack_lambda_critical_notifications ? 1 : 0

  name        = "${local.name_prefix}-slack-lambda"
  description = "security group for sns to slack lambda"

  vpc_id = var.vpc_id

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-slack-lambda"
    Owner       = var.owner
  }

  provider = aws.default
}

