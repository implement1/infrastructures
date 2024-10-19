resource "aws_backup_vault" "default" {
  name = local.name_prefix

  kms_key_arn = var.kms_key_arn

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = local.name_prefix
    Owner       = var.owner
  }

  provider = aws.default
}

data "aws_iam_policy_document" "backup_vault_policy" {
  statement {
    sid    = "Allow ${var.backup_account_id} to copy into ${local.name_prefix}"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.backup_account_id}:root"]
    }
    actions = [
      "backup:CopyIntoBackupVault",
    ]
    resources = ["*"]

  }

  provider = aws.default
}

resource "aws_backup_vault_policy" "default" {
  backup_vault_name = aws_backup_vault.default.name

  policy = data.aws_iam_policy_document.backup_vault_policy.json

  provider = aws.default
}
