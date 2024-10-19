module "inspector" {
  source = "./modules/inspector"

  sns_topic_critical_arn = module.sns_topics.sns_topic_critical_arn

  aws_region  = var.aws_region
  environment = var.environment
  owner       = var.owner

  providers = {
    aws.default = aws.default
  }
}
