resource "aws_cloudwatch_log_group" "default" {
  count = var.elasticsearch_log_publishing_enabled ? 1 : 0

  name              = local.cloudwatch_log_group_name
  retention_in_days = var.cw_log_group_default_retention_in_days

  kms_key_id = var.kms_key_arn

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = local.cloudwatch_log_group_name
    Owner       = var.owner
  }

  provider = aws.default
}

data "aws_iam_policy_document" "default_elasticsearch" {
  count = var.elasticsearch_log_publishing_enabled ? 1 : 0

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:PutLogEventsBatch",
    ]

    resources = [
      aws_cloudwatch_log_group.default[0].arn,
    ]

    principals {
      identifiers = ["es.amazonaws.com"]
      type        = "Service"
    }
  }

  provider = aws.default
}

resource "aws_cloudwatch_log_resource_policy" "default_elasticsearch" {
  count = var.elasticsearch_log_publishing_enabled ? 1 : 0

  policy_name     = local.name_prefix
  policy_document = data.aws_iam_policy_document.default_elasticsearch[0].json

  provider = aws.default
}
