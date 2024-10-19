resource "aws_lambda_permission" "sns_non_critical" {
  count = var.enable_slack_lambda_non_critical_notifications ? 1 : 0

  function_name = aws_lambda_function.slack[0].id
  action        = "lambda:InvokeFunction"

  principal    = "sns.amazonaws.com"
  statement_id = "AllowSubscriptionToNonCriticalSNS"
  source_arn   = aws_sns_topic.non_critical.arn

  provider = aws.default
}

resource "aws_sns_topic_subscription" "slack_non_critical_subscription" {
  count = var.enable_slack_lambda_non_critical_notifications ? 1 : 0

  topic_arn = aws_sns_topic.non_critical.arn
  endpoint  = aws_lambda_function.slack[0].arn
  protocol  = "lambda"

  provider = aws.default
}

resource "aws_lambda_permission" "sns_critical" {
  count = var.enable_slack_lambda_critical_notifications ? 1 : 0

  function_name = aws_lambda_function.slack[0].id
  action        = "lambda:InvokeFunction"

  principal    = "sns.amazonaws.com"
  statement_id = "AllowSubscriptionToCriticalSNS"
  source_arn   = aws_sns_topic.critical.arn

  provider = aws.default
}

resource "aws_sns_topic_subscription" "slack_critical_subscription" {
  count = var.enable_slack_lambda_critical_notifications ? 1 : 0

  topic_arn = aws_sns_topic.critical.arn
  endpoint  = aws_lambda_function.slack[0].arn
  protocol  = "lambda"

  provider = aws.default
}
