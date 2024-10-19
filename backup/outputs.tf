output "backup_vault_id" {
  value = aws_backup_vault.default.id
}

output "backup_vault_arn" {
  value = aws_backup_vault.default.arn
}

output "backup_vault_recovery_points" {
  value = aws_backup_vault.default.recovery_points
}

output "backup_iam_role_arn" {
  value = aws_iam_role.default.arn
}

output "backup_iam_role_name" {
  value = aws_iam_role.default.name
}
