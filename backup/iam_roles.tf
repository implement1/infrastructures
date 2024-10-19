data "aws_iam_policy_document" "backup_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }
  }

  provider = aws.default
}

resource "aws_iam_role" "default" {
  name = local.name_prefix

  assume_role_policy = data.aws_iam_policy_document.backup_assume_role.json

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = local.name_prefix
    Owner       = var.owner
  }

  provider = aws.default
}

data "aws_iam_policy_document" "backup_assume_backup_account_role_policy" {
  statement {
    sid     = "AssumeBackupAccountIAMRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    resources = [
      "arn:aws:iam::${var.backup_account_id}:role/${local.name_prefix}",
    ]
  }

  provider = aws.default
}

resource "aws_iam_role_policy" "default_backup_account" {
  name = "cross-account-to-backup-account"
  role = aws_iam_role.default.id

  policy = data.aws_iam_policy_document.backup_assume_backup_account_role_policy.json

  provider = aws.default
}

data "aws_iam_policy_document" "backup_kms_access" {
  statement {
    sid    = "AllowKMSAccessForSnapshotsWithCustomerKMS"
    effect = "Allow"
    actions = [
      "kms:DescribeKey",
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:GenerateDataKey",
      "kms:ReEncrypt",
    ]
    resources = ["*"]
  }

  provider = aws.default
}

resource "aws_iam_role_policy" "backup_kms_access" {
  name = "kms-key-access"
  role = aws_iam_role.default.id

  policy = data.aws_iam_policy_document.backup_kms_access.json

  provider = aws.default
}

resource "aws_iam_role_policy_attachment" "backup" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.default.name

  provider = aws.default
}

resource "aws_iam_role_policy_attachment" "restore" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
  role       = aws_iam_role.default.name

  provider = aws.default
}
