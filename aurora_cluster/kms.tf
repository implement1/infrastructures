data "aws_iam_policy_document" "kms_default" {
  version = "2012-10-17"

  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.default.account_id}:root",
      ]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }

  statement {
    sid    = "Allow Backup Account Permissions"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${var.backup_account_id}:root",
      ]
    }
    actions = [
      "kms:CreateGrant",
      "kms:DescribeKey",
    ]
    resources = ["*"]
  }

  provider = aws.default
}

resource "aws_kms_key" "aurora_default" {
  description         = "kms key for ${var.environment} aurora cluster"
  enable_key_rotation = true

  policy = data.aws_iam_policy_document.kms_default.json

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = "${local.name_prefix}-default"
    Owner       = var.owner
  }

  provider = aws.default
}

resource "aws_kms_alias" "aurora_default" {
  name          = "alias/${local.name_prefix}-default"
  target_key_id = aws_kms_key.aurora_default.key_id

  provider = aws.default
}
