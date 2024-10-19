variable "aws_region" {
  type        = string
  description = "aws region to deploy to"
}

variable "application" {
  type        = string
  description = "used for naming resources and tagging"
  default     = "sns"
}

variable "component" {
  type        = string
  description = "used for naming resources and tagging"
  default     = "topic"
}

variable "environment" {
  type        = string
  description = "used for naming resources and tagging"
}

variable "owner" {
  type        = string
  description = "used for tagging reources"
}

# https://docs.aws.amazon.com/inspector/latest/userguide/inspector_assessments.html#sns-topic
variable "aws_inspector_account_id" {
  type        = number
  description = "the source account for aws inspector"
  default     = 758058086616
}

# cloudwatch
variable "cw_log_group_default_retention_in_days" {
  type        = number
  description = "amount of days to keep cloudwatch logs"
}

# kms
variable "kms_key_arn" {
  type        = string
  description = "the arn of the kms key to use for encryption"
}

# vpc
variable "vpc_id" {
  type        = string
  description = "the vpc id to place resources"
}

variable "vpc_app_subnets" {
  type        = list(string)
  description = "list of subnet ids to place resources in"
}

# slack lambda
variable "enable_slack_lambda_non_critical_notifications" {
  type        = bool
  description = "enable slack lambda notifications from sns topic for non critical notifications"
  default     = false
}

variable "enable_slack_lambda_critical_notifications" {
  type        = bool
  description = "enable slack lambda notifications from sns topic for critical notifications"
  default     = false
}
