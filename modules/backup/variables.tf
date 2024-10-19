variable "aws_region" {
  type        = string
  description = "aws region to deploy to"
}

variable "application" {
  type        = string
  description = "used for naming resources and tagging"
  default     = "account"
}

variable "component" {
  type        = string
  description = "used for naming resources and tagging"
  default     = "backup"
}

variable "environment" {
  type        = string
  description = "used for naming resources and tagging"
}

variable "owner" {
  type        = string
  description = "used for tagging reources"
}

# backup account
variable "backup_account_id" {
  type        = number
  description = "the account number of the backup account"
}

# kms
variable "kms_key_arn" {
  type        = string
  description = "the kms key arn to use for encryption the backup vault"
}

