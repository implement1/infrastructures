module "sns_topics" {
  source = "./modules/sns-topics"

  aws_region  = var.aws_region
  environment = var.environment
  owner       = var.owner

  cw_log_group_default_retention_in_days = var.cw_log_group_default_retention_in_days

  vpc_id          = module.vpc.vpc_id
  vpc_app_subnets = module.vpc.app_subnets_ids

  kms_key_arn = aws_kms_alias.default.target_key_arn

  enable_slack_lambda_non_critical_notifications = var.enable_slack_lambda_non_critical_notifications
  enable_slack_lambda_critical_notifications     = var.enable_slack_lambda_critical_notifications

  providers = {
    aws.default = aws.default
  }
}

output "sns_topic_non_critical_arn" {
  value = module.sns_topics.sns_topic_non_critical_arn
}

output "sns_topic_critical_arn" {
  value = module.sns_topics.sns_topic_critical_arn
}
