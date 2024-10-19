module "elasticsearch" {
  source = "./modules/elasticsearch"

  # tags and # naming
  aws_region  = var.aws_region
  application = var.application
  component   = "elasticsearch"
  environment = var.environment
  owner       = var.owner

  cw_log_group_default_retention_in_days = var.cw_log_group_default_retention_in_days

  elasticsearch_instance_count = var.elasticsearch_instance_count
  elasticsearch_instance_size  = var.elasticsearch_instance_size

  elasticsearch_ebs_enabled     = var.elasticsearch_ebs_enabled
  elasticsearch_ebs_volume_size = var.elasticsearch_ebs_volume_size
  elasticsearch_ebs_volume_type = var.elasticsearch_ebs_volume_type

  elasticsearch_advanced_options = var.elasticsearch_advanced_options

  kms_key_arn = aws_kms_alias.default.target_key_arn

  vpc_id         = module.vpc.vpc_id
  vpc_subnet_ids = module.vpc.app_subnets_ids

  providers = {
    aws.default = aws.default
  }
}

output "elasticsearch_cloudwatch_log_group_name" {
  value = module.elasticsearch.cloudwatch_log_group_name
}

output "elasticsearch_server_security_group_id" {
  value = module.elasticsearch.server_security_group_id
}

output "elasticsearch_client_security_group_id" {
  value = module.elasticsearch.client_security_group_id
}

output "elasticsearch_domain_arn" {
  value = module.elasticsearch.elasticsearch_domain_arn
}

output "elasticsearch_domain_id" {
  value = module.elasticsearch.elasticsearch_domain_id
}

output "elasticsearch_domain_name" {
  value = module.elasticsearch.elasticsearch_domain_name
}

output "elasticsearch_endpoint" {
  value = module.elasticsearch.elasticsearch_endpoint
}

output "elasticsearch_kibana_endpointkibana_endpoint" {
  value = module.elasticsearch.kibana_endpoint
}
