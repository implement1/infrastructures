resource "aws_cloudwatch_event_rule" "default" {
  name        = local.name_prefix
  description = "rule for inspector to run"

  schedule_expression = "rate(7 days)"

  provider = aws.default
}

resource "aws_cloudwatch_event_target" "default" {
  rule      = aws_cloudwatch_event_rule.default.name
  target_id = "default"
  arn       = aws_inspector_assessment_template.default.arn

  role_arn = aws_iam_role.events_default.arn

  provider = aws.default
}

resource "aws_cloudwatch_metric_alarm" "event_rule_failed_invocations" {
  alarm_name        = local.name_prefix
  alarm_description = "alarms triggers with the cloudwatch rule for inspector fails"

  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "FailedInvocations"
  namespace           = "AWS/Events"
  period              = 300
  statistic           = "Average"
  threshold           = 1

  treat_missing_data = "missing"

  dimensions = {
    RuleName = aws_cloudwatch_event_rule.default.id
  }

  alarm_actions = [
    var.sns_topic_critical_arn
  ]

  ok_actions = [
    var.sns_topic_critical_arn,
  ]

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = local.name_prefix
    Owner       = var.owner
  }

  provider = aws.default
}
