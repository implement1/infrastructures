module "backup" {
  source = "./modules/backup"

  # backup account
  backup_account_id = var.backup_account_id

  # kms
  kms_key_arn = aws_kms_alias.default.target_key_arn

  aws_region  = var.aws_region
  environment = var.environment
  owner       = var.owner

  providers = {
    aws.default = aws.default
  }
}

output "backup_vault_id" {
  value = module.backup.backup_vault_id
}

output "backup_vault_arn" {
  value = module.backup.backup_vault_arn
}

output "backup_iam_role_arn" {
  value = module.backup.backup_iam_role_arn
}

output "backup_iam_role_name" {
  value = module.backup.backup_iam_role_name
}
