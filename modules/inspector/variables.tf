variable "aws_region" {
  type        = string
  description = "aws region to deploy to"
}

variable "application" {
  type        = string
  description = "used for naming resources and tagging"
  default     = "inspector"
}

variable "component" {
  type        = string
  description = "used for naming resources and tagging"
  default     = "per-region"
}

variable "environment" {
  type        = string
  description = "used for naming resources and tagging"
}

variable "owner" {
  type        = string
  description = "used for tagging reources"
}

# sns
variable "sns_topic_critical_arn" {
  type        = string
  description = "critical sns topic"
}
