data "aws_iam_policy_document" "events_assume_role" {
  version = "2012-10-17"

  statement {
    sid = "AllowECSAssumeRole"

    effect = "Allow"

    principals {
      type = "Service"

      identifiers = [
        "events.amazonaws.com",
      ]
    }

    actions = ["sts:AssumeRole"]
  }

  provider = aws.default
}

resource "aws_iam_role" "events_default" {
  name = "${local.name_prefix}-events"

  assume_role_policy = data.aws_iam_policy_document.events_assume_role.json

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-events"
    Owner       = var.owner
  }

  provider = aws.default
}


data "aws_iam_policy_document" "events_default" {
  version = "2012-10-17"

  statement {
    sid    = "AllowInspector"
    effect = "Allow"
    actions = [
      "inspector:StartAssessmentRun",
    ]
    resources = ["*"]
  }

  provider = aws.default
}

resource "aws_iam_role_policy" "events_default" {
  name = "${local.name_prefix}-default"
  role = aws_iam_role.events_default.id

  policy = data.aws_iam_policy_document.events_default.json

  provider = aws.default
}
