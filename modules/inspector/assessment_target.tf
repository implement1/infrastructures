resource "aws_inspector_assessment_target" "default" {
  name = local.name_prefix

  provider = aws.default
}
