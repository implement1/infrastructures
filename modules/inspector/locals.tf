# naming
locals {
  name_prefix = lower(format("%s-%s", var.environment, var.application))
}
