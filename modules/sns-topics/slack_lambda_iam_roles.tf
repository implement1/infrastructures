data "aws_iam_policy_document" "slack_lambda" {
  version = "2012-10-17"

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }

  provider = aws.default
}

resource "aws_iam_role" "slack_lambda" {
  count = var.enable_slack_lambda_non_critical_notifications || var.enable_slack_lambda_critical_notifications ? 1 : 0

  name = "${local.name_prefix}-slack-lambda"

  assume_role_policy = data.aws_iam_policy_document.slack_lambda.json

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-lambda"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_iam_role_policy_attachment" "slack_lambda_logs_vpc" {
  count = var.enable_slack_lambda_non_critical_notifications || var.enable_slack_lambda_critical_notifications ? 1 : 0

  role       = aws_iam_role.slack_lambda[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"

  provider = aws.default
}
