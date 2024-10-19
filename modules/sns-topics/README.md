# sns topics module

Creates two sns-topics. Once critical and one non-critical for applications to use

## Usage

If you enable slack notifications, the ssm parameter `/<environment>/slack/hook_url` must exist with a valid slack URL

### Example

```
module "sns_topics" {
  source = "./modules/sns-topics"

  aws_region  = "us-east-1"
  environment = "dev"
  owner       = "exmaple"

  enable_slack_lambda_non_critical_notifications = true
  enable_slack_lambda_critical_notifications     = true

  providers = {
    aws.default = aws.default
  }
}
```

### Outputs from module

```
output "sns_topic_non_critical_arn" {
  value = module.sns_topics.sns_topic_non_critical_arn
}

output "sns_topic_critical_arn" {
  value = module.sns_topics.sns_topic_critical_arn
}
```
