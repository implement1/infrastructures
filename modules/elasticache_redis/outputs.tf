output "client_security_group" {
  value = aws_security_group.server.id
}

output "server_security_group" {
  value = aws_security_group.client.id
}

output "elasticache_id" {
  value = aws_elasticache_replication_group.default.id
}

output "elasticache_arn" {
  value = aws_elasticache_replication_group.default.arn
}

output "primary_endpoint_address" {
  value = aws_elasticache_replication_group.default.primary_endpoint_address
}

output "reader_endpoint_address" {
  value = aws_elasticache_replication_group.default.reader_endpoint_address
}
