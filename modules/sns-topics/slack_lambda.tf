resource "aws_cloudwatch_log_group" "slack_lambda" {
  count = var.enable_slack_lambda_non_critical_notifications || var.enable_slack_lambda_critical_notifications ? 1 : 0

  name              = "/aws/lambda/${aws_lambda_function.slack[0].function_name}"
  retention_in_days = var.cw_log_group_default_retention_in_days

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "/aws/lambda/${aws_lambda_function.slack[0].function_name}"
    Owner       = var.owner
  }

  provider = aws.default
}

data "archive_file" "slack_lambda" {
  count = var.enable_slack_lambda_non_critical_notifications || var.enable_slack_lambda_critical_notifications ? 1 : 0

  type        = "zip"
  source_dir  = "${path.module}/lambda/slack/"
  output_path = "${path.module}/lambda/lambda.zip"
}

resource "aws_lambda_function" "slack" {
  count = var.enable_slack_lambda_non_critical_notifications || var.enable_slack_lambda_critical_notifications ? 1 : 0

  function_name = "${local.name_prefix}-slack"
  description   = "lambda function for slack"

  filename         = data.archive_file.slack_lambda[0].output_path
  source_code_hash = data.archive_file.slack_lambda[0].output_base64sha256

  runtime = "python3.8"
  handler = "lambda.lambda_handler"

  timeout     = 15
  memory_size = 128

  environment {
    variables = {
      SLACK_HOOK_URL = data.aws_ssm_parameter.slack_hook_url[0].value
    }
  }

  role        = aws_iam_role.slack_lambda[0].arn
  kms_key_arn = var.kms_key_arn

  vpc_config {
    subnet_ids = var.vpc_app_subnets
    security_group_ids = [
      aws_security_group.slack_lambda[0].id,
    ]
  }

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-slack"
    Owner       = var.owner
  }

  provider = aws.default
}
