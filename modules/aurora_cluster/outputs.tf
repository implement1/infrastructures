output "aurora_write_endpoint" {
  value = aws_rds_cluster.default.endpoint
}

output "aurora_read_endpoint" {
  value = aws_rds_cluster.default.reader_endpoint
}

output "aurora_server_security_group" {
  value = aws_security_group.server.id
}

output "aurora_client_security_group" {
  value = aws_security_group.client.id
}
