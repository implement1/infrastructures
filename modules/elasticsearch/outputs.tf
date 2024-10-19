output "cloudwatch_log_group_name" {
  value = local.cloudwatch_log_group_name
}

output "client_security_group_id" {
  value = aws_security_group.client.id
}

output "server_security_group_id" {
  value = aws_security_group.server.id
}

output "elasticsearch_domain_arn" {
  value = aws_elasticsearch_domain.default.arn
}

output "elasticsearch_domain_id" {
  value = aws_elasticsearch_domain.default.domain_id
}

output "elasticsearch_domain_name" {
  value = aws_elasticsearch_domain.default.domain_name
}

output "elasticsearch_endpoint" {
  value = aws_elasticsearch_domain.default.endpoint
}

output "kibana_endpoint" {
  value = aws_elasticsearch_domain.default.kibana_endpoint
}
