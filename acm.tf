output "acm_certificate_arn" {
  value = aws_acm_certificate.default.arn
}

resource "aws_acm_certificate" "default" {
  domain_name = var.hosted_zone_domain_name

  subject_alternative_names = [
    "*.${var.hosted_zone_domain_name}",
  ]

  validation_method = "DNS"

  options {
    certificate_transparency_logging_preference = "ENABLED"
  }

  tags = {
    Application = var.application
    Component   = var.component
    Environment = var.environment
    Name        = var.hosted_zone_domain_name
    Owner       = var.owner
  }

  provider = aws.default
}
