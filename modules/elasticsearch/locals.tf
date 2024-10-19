# naming
locals {
  name_prefix = lower(format("%s-%s-%s", var.environment, var.application, var.component))

  cloudwatch_log_group_name = "/${var.environment}/${var.application}/${var.component}/elasticsearch"
}