resource "aws_cloudwatch_event_rule" "guardduty" {
  name        = "${local.name_prefix}-guardduty"
  description = "rule for guardduty to send custom sns notifications"

  event_pattern = jsonencode({
    "source" = ["aws.guardduty"],
    "detail" = {
      "severity" = [
        4, 4.0, 4.1, 4.2, 4.3, 4.4, 4.5, 4.6, 4.7, 4.8, 4.9,
        5, 5.0, 5.1, 5.2, 5.3, 5.4, 5.5, 5.6, 5.7, 5.8, 5.9,
        6, 6.0, 6.1, 6.2, 6.3, 6.4, 6.5, 6.6, 6.7, 6.8, 6.9,
        7, 7.0, 7.1, 7.2, 7.3, 7.4, 7.5, 7.6, 7.7, 7.8, 7.9,
        8, 8.0, 8.1, 8.2, 8.3, 8.4, 8.5, 8.6, 8.7, 8.8, 8.9,
      ]
    }
  })

  provider = aws.default
}

data "template_file" "guardduty_sns" {
  template = file("${path.module}/templates/cloudwatch/guardduty_sns.tpl")
}

resource "aws_cloudwatch_event_target" "guardduty_sns" {
  rule      = aws_cloudwatch_event_rule.guardduty.name
  target_id = "to-sns"
  arn       = module.sns_topics.sns_topic_critical_arn

  input_transformer {
    input_paths = {
      severity     = "$.detail.severity",
      account_id   = "$.detail.accountId",
      finding_id   = "$.detail.id",
      finding_desc = "$.detail.description",
      finding_type = "$.detail.type",
      region       = "$.region",
    }
    input_template = data.template_file.guardduty_sns.rendered
  }

  provider = aws.default
}

resource "aws_cloudwatch_metric_alarm" "guardduty_sns_topic_failed_invocations" {
  alarm_name        = "${local.name_prefix}-guardduty-sns-failed-invocations"
  alarm_description = "alarms triggers with the cloudwatch rule for guardduty fails delivering to sns"

  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "FailedInvocations"
  namespace           = "AWS/Events"
  period              = 300
  statistic           = "Average"
  threshold           = 1

  treat_missing_data = "missing"

  dimensions = {
    RuleName = aws_cloudwatch_event_rule.guardduty.id
  }

  alarm_actions = [
    module.sns_topics.sns_topic_critical_arn,
  ]

  ok_actions = [
    module.sns_topics.sns_topic_critical_arn,
  ]

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-guardduty-sns-failed-invocations"
    Owner       = var.owner
  }

  provider = aws.default
}
