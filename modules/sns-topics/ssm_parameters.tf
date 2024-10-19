data "aws_ssm_parameter" "slack_hook_url" {
  count = var.enable_slack_lambda_non_critical_notifications || var.enable_slack_lambda_critical_notifications ? 1 : 0

  name            = "/${var.environment}/slack/hook_url"
  with_decryption = true

  provider = aws.default
}
