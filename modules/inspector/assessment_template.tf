resource "aws_inspector_assessment_template" "default" {
  name       = local.name_prefix
  target_arn = aws_inspector_assessment_target.default.arn

  duration = 3600

  rules_package_arns = [
    "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-9hgA516p",
    "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-H5hpSawc",
    "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-JJOtZiqQ",
    "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-rD1z6dpl",
  ]

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = local.name_prefix
    Owner       = var.owner
  }

  provider = aws.default
}
