# vpc module

Creates a three tier VPC with a public, app, and db subnets

## Usage

### Example

```
module "default" {
  source = "./modules/vpc"

  application = "app"
  environment = "dev"
  owner       = "example"

  aws_region         = "us-east-1"
  vpc_cidr_block     = "10.0.0.1/16"
  availability_zones = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
  ]

  providers = {
    aws.default = aws.default
  }
}
```

### Outputs from module

```
output "default_vpc_nat_ip_addresses" {
  value = module.default.*.nat_ip_addresses
}

output "default_vpc_id" {
  value = module.default.*.vpc_id
}

output "default_vpc_public_subnets_cidr_block" {
  value = module.default.*.public_subnets_cidr_block
}

output "default_vpc_public_subnet_ids" {
  value = module.default.*.public_subnets_ids
}

output "default_vpc_app_subnets_cidr_block" {
  value = module.default.*.app_subnets_cidr_block
}

output "default_vpc_app_subnet_ids" {
  value = module.default.*.app_subnets_ids
}

output "default_vpc_db_subnets_cidr_block" {
  value = module.default.*.db_subnets_cidr_block
}

output "default_vpc_db_subnet_ids" {
  value = module.default.*.db_subnets_ids
}
```
