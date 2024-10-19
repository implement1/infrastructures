# naming and tags
variable "aws_region" {
  type        = string
  description = "aws region to deploy to"
}

variable "application" {
  type        = string
  description = "used for naming resources and tagging"
  default     = "aurora"
}

variable "component" {
  type        = string
  description = "used for naming resources and tagging"
  default     = "cluster"
}

variable "environment" {
  type        = string
  description = "used for naming resources and tagging"
}

variable "owner" {
  type        = string
  description = "used for tagging reources"
}

# backup
variable "backup" {
  type        = bool
  description = "true is resources should be backed up by AWS backup"
}

variable "backup_account_id" {
  type        = number
  description = "the account number of the backup account"
}

# sns
variable "sns_topic_critical_arn" {
  type        = string
  description = "critical sns topic"
}

variable "sns_topic_non_critical_arn" {
  type        = string
  description = "critical sns topic"
}

# vpc
variable "vpc_id" {
  type        = string
  description = "the id of the VPC where app lives"
}

variable "vpc_db_subnets" {
  type        = list(string)
  description = "the database subnets for the vpc this environment goes in"
}

variable "vpc_db_availability_zones" {
  type        = list(string)
  description = "the list of availability zones for the rds cluster"
}

# aurora
variable "aurora_admin_username" {
  type        = string
  description = "the aurora admin username for cluster"
  default     = "confirmhradmin"
}
variable "aurora_default_database_name" {
  type        = string
  description = "default database name for rds"
  default     = "do_not_use"
}

variable "aurora_iam_database_authentication_enabled" {
  type        = bool
  description = "whether iam users can auth to rds with iam creds"
  default     = false
}

variable "aurora_instance_count" {
  type        = number
  description = "the number or instances to create in the cluster"
  default     = 0
}

variable "aurora_engine" {
  type        = string
  description = "the rds engine to use for the rds instance(s)"
}

variable "aurora_engine_version" {
  type        = string
  description = "the rds engine version to use for the rds instance(s)"
}

variable "aurora_default_port" {
  type        = number
  description = "the port to use for the rds instance(s)"
  default     = 5432
}

variable "aurora_publicly_accessible" {
  type        = bool
  description = "specify if the rds instance(s) should be publicly available"
  default     = false
}

variable "aurora_apply_immediately" {
  type        = bool
  description = "whether to apply changes here immediately or wait til maintenance window"
  default     = false
}

variable "aurora_deletion_protection" {
  type        = bool
  description = "enable deletion protection on rds"
  default     = true
}

variable "aurora_ca_cert_identifier" {
  type        = string
  description = "the ca cert to use for rds"
  default     = "rds-ca-2019"
}

variable "aurora_auto_minor_version_upgrade" {
  type        = bool
  description = "allow instances to auto upgrade minor versions during maintenance window"
  default     = false
}

variable "aurora_allow_major_version_upgrade" {
  type        = bool
  description = "allow major version upgrades during maintenance windows"
  default     = false
}

variable "aurora_maintenance_window" {
  type        = string
  description = "window to perform maintenance in"
  default     = null
}

variable "aurora_backup_window" {
  type        = string
  description = "daily time range (in UTC) during which automated backups are created"
  default     = null
}

variable "aurora_backup_retention_period" {
  type        = number
  description = "days to retain backups for [0 - 35]"
}

variable "aurora_copy_tags_to_snapshot" {
  type        = bool
  description = "copy tags to snapshots"
  default     = true
}

variable "aurora_instance_class" {
  type        = string
  description = "the instance class to use for creating rds instance(s)"
}

variable "aurora_storage_encrypted" {
  type        = bool
  description = "encrypt rds storage at rest"
  default     = true
}

variable "aurora_parameter_group_family_name" {
  type        = string
  description = "the family of db parameter group"
}

variable "aurora_parameter_group_log_min_duration_statement" {
  type        = number
  description = "log only statements slower than (ms)"
}

variable "aurora_enabled_cloudwatch_logs_exports" {
  type        = list(string)
  description = "Set of log types to enable for exporting to CloudWatch logs."
}

# cloudwatch
variable "freeable_memory_threshold_non_critical" {
  type        = number
  description = "the threshold to set for non crtical alert"
}

variable "freeable_memory_threshold_critical" {
  type        = number
  description = "the threshold to set for crtical alert"
}

variable "cpu_utilization_threshold_non_critical" {
  type        = number
  description = "the threshold to set for non crtical alert"
}

variable "cpu_utilization_threshold_critical" {
  type        = number
  description = "the threshold to set for crtical alert"
}
