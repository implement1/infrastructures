data "aws_iam_policy_document" "kms_policy" {
  version = "2012-10-17"

  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.account.account_id}:root",
      ]
    }

    actions = [
      "kms:*",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "ebs volume"
    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.account.account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling",
        "arn:aws:sts::${data.aws_caller_identity.account.account_id}:assumed-role/AWSServiceRoleForAutoScaling/AutoScaling",
      ]
    }

    actions = [
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:Encrypt",
      "kms:GenerateDataKey*",
      "kms:ReEncrypt*",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "persistent resources"
    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.account.account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling",
        "arn:aws:sts::${data.aws_caller_identity.account.account_id}:assumed-role/AWSServiceRoleForAutoScaling/AutoScaling",
      ]
    }

    actions = [
      "kms:CreateGrant",
    ]

    resources = ["*"]

    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values = [
        true,
      ]
    }
  }

  statement {
    sid    = "cloudwatch logs"
    effect = "Allow"

    principals {
      type = "Service"
      identifiers = [
        "logs.${var.aws_region}.amazonaws.com",
      ]
    }

    actions = [
      "kms:Decrypt*",
      "kms:Describe*",
      "kms:Encrypt*",
      "kms:GenerateDataKey*",
      "kms:ReEncrypt*",
    ]

    resources = ["*"]

    condition {
      test     = "ArnLike"
      variable = "kms:EncryptionContext:aws:logs:arn"
      values = [
        "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.account.account_id}:*",
      ]
    }
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

resource "aws_kms_key" "default" {
  description         = "default kms key for ${var.environment} account"
  enable_key_rotation = true

  policy = data.aws_iam_policy_document.kms_policy.json

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = local.name_prefix
    Owner       = var.owner
  }

  depends_on = [
    aws_iam_service_linked_role.autoscaling,
  ]

  provider = aws.default
}

resource "aws_kms_alias" "default" {
  name          = "alias/${local.name_prefix}"
  target_key_id = aws_kms_key.default.key_id

  depends_on = [
    aws_kms_key.default,
  ]

  provider = aws.default
}
