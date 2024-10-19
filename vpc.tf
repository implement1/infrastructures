module "vpc" {
  source = "./modules/vpc"

  aws_region = var.aws_region

  application = var.application
  environment = var.environment
  owner       = var.owner

  vpc_cidr_block     = var.vpc_cidr_block
  availability_zones = var.vpc_availability_zones

  providers = {
    aws.default = aws.default
  }
}

output "vpc_nat_ip_addresses" {
  value = module.vpc.*.nat_ip_addresses
}

output "vpc_id" {
  value = module.vpc.*.vpc_id
}

output "vpc_public_subnets_cidr_block" {
  value = module.vpc.*.public_subnets_cidr_block
}

output "vpc_public_subnet_ids" {
  value = module.vpc.*.public_subnets_ids
}

output "vpc_app_subnets_cidr_block" {
  value = module.vpc.*.app_subnets_cidr_block
}

output "vpc_app_subnet_ids" {
  value = module.vpc.*.app_subnets_ids
}

output "vpc_db_subnets_cidr_block" {
  value = module.vpc.*.db_subnets_cidr_block
}

output "vpc_db_subnet_ids" {
  value = module.vpc.*.db_subnets_ids
}
