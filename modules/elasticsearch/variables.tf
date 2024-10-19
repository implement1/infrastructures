variable "aws_region" {
  type        = string
  description = "aws region to deploy to"
}

variable "application" {
  type        = string
  description = "used for naming resources and tagging"
}

variable "component" {
  type        = string
  description = "used for naming resources and tagging"
}

variable "environment" {
  type        = string
  description = "used for naming resources and tagging"
}

variable "owner" {
  type        = string
  description = "used for tagging reources"
}

# cloudwatch
variable "cw_log_group_default_retention_in_days" {
  type        = number
  description = "amount of days to keep cloudwatch logs"
}

# elasticsearch
variable "elasticsearch_version" {
  type        = string
  description = "the verison of elasticsearch to use"
  default     = "7.10"
}

variable "elasticsearch_instance_count" {
  type        = number
  description = "the number of instances to add to the elasticsearch cluster"
}

variable "elasticsearch_instance_size" {
  type        = string
  description = "the instance type to use for elasticsearch"
}

variable "elasticsearch_ebs_enabled" {
  type        = bool
  description = "enable ebs on elasticsearch. Needed for some instance types"
  default     = false
}

variable "elasticsearch_ebs_volume_size" {
  type        = number
  description = "the ebs volume size to use for the ebs volume (in GiB)"
}

variable "elasticsearch_ebs_volume_type" {
  type        = string
  description = "the volume type to use with ebs [standard, gp2, io1]"
}

variable "elasticsearch_access_policies" {
  type        = string
  description = "json encoded string access policy for elasticsearch"
  default     = null
}

variable "elasticsearch_advanced_options" {
  type        = map(any)
  description = "map of options to add to elasticsearch"
  default     = {}
}

variable "elasticsearch_log_publishing_enabled" {
  type        = bool
  description = "enable cloudwatch logs for elasticsearch"
  default     = false
}

variable "elasticsearch_log_publishing_types" {
  type        = list(string)
  description = "types of logs to publish to cloudwatch [INDEX_SLOW_LOGS, SEARCH_SLOW_LOGS, ES_APPLICATION_LOGS, AUDIT_LOGS]"
  default     = []
}

variable "elasticsearch_automated_snapshot_start_hour" {
  type        = number
  description = "the hour to start automated snapshots [00-24]"
  default     = 02
}

# kms
variable "kms_key_arn" {
  type        = string
  description = "the arn of the kms key to use for encryption"
}

# vpc
variable "vpc_id" {
  type        = string
  description = "the vpc id to place the elasticsearch cluster"
}

variable "vpc_subnet_ids" {
  type        = list(string)
  description = "list of subnet ids to place elasticsearch in"
}
