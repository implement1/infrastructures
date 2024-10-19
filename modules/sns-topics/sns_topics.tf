output "sns_topic_non_critical_arn" {
  value = aws_sns_topic.non_critical.arn
}

output "sns_topic_critical_arn" {
  value = aws_sns_topic.critical.arn
}

# naming
locals {
  name_prefix = lower(format("%s-%s-%s", var.environment, var.application, var.component))
}

data "aws_iam_policy_document" "sns_topic_non_critical_default" {
  version = "2008-10-17"

  statement {
    sid    = "__default_statement_ID"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "SNS:AddPermission",
      "SNS:DeleteTopic",
      "SNS:GetTopicAttributes",
      "SNS:ListSubscriptionsByTopic",
      "SNS:Publish",
      "SNS:Receive",
      "SNS:RemovePermission",
      "SNS:SetTopicAttributes",
      "SNS:Subscribe",
    ]

    resources = [
      aws_sns_topic.non_critical.arn,
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        data.aws_caller_identity.account.account_id,
      ]
    }
  }

  statement {
    sid = "allow_cloudwatch_events"

    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [aws_sns_topic.non_critical.arn]
  }

  statement {
    sid = "allow_inspector"

    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      type        = "Service"
      identifiers = ["inspector.amazonaws.com"]
    }

    resources = [aws_sns_topic.non_critical.arn]
  }

  provider = aws.default
}

resource "aws_sns_topic" "non_critical" {
  name = "${local.name_prefix}-non-critical"

  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultThrottlePolicy": {
      "maxReceivesPerSecond": 1
    }
  }
}
EOF

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-non-critical"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_sns_topic_policy" "non_critical_default" {
  arn    = aws_sns_topic.non_critical.arn
  policy = data.aws_iam_policy_document.sns_topic_non_critical_default.json

  provider = aws.default
}

data "aws_iam_policy_document" "sns_topic_critical_default" {
  version = "2008-10-17"

  statement {
    sid = "__default_statement_ID"

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "SNS:AddPermission",
      "SNS:DeleteTopic",
      "SNS:GetTopicAttributes",
      "SNS:ListSubscriptionsByTopic",
      "SNS:Publish",
      "SNS:Receive",
      "SNS:RemovePermission",
      "SNS:SetTopicAttributes",
      "SNS:Subscribe",
    ]

    resources = [
      aws_sns_topic.critical.arn,
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        data.aws_caller_identity.account.account_id,
      ]
    }
  }

  statement {
    sid = "allow_cloudwatch_events"

    effect = "Allow"

    actions = [
      "SNS:Publish",
    ]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [aws_sns_topic.critical.arn]
  }

  statement {
    sid = "allow_inspector"

    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      type        = "Service"
      identifiers = ["inspector.amazonaws.com"]
    }

    resources = [aws_sns_topic.critical.arn]
  }

  provider = aws.default
}

resource "aws_sns_topic" "critical" {
  name            = "${local.name_prefix}-critical"
  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultThrottlePolicy": {
      "maxReceivesPerSecond": 1
    }
  }
}
EOF

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-critical"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_sns_topic_policy" "critical_default" {
  arn    = aws_sns_topic.critical.arn
  policy = data.aws_iam_policy_document.sns_topic_critical_default.json

  provider = aws.default
}
