# aurora module

Creates a aurora cluster

## Usage

### Requirements

This module will create a username and password for the cluster. The password is randomly generated and will be saved to secrets manager.

If you want to change the default username `admin`, please include the `aurora_admin_username` variable when calling this module.


### Example

```
module "aurora_cluster" {
  source = "./modules/aurora_cluster"

  # tags
  environment = "dev"
  owner       = "example`

  aws_region = "us-east-1"

  # vpc settings
  vpc_id = "vpc-3243fdgfd8dfg"
  vpc_db_availability_zones = [
      "us-east-1a",
      "us-east-1b",
      "us-east-1c",
  ]
  vpc_db_subnets = [
      "subnet-3434k3j243k4j34j",
      "subnet-343jkjkj343432",
      "subnet-80890awdawdwa",
  ]

  # aurora settings
  aurora_instance_count = 2
  aurora_instance_class = "db.t3.small"

  aurora_engine                      = "aurora-postgresql"
  aurora_engine_version              = "12.4"
  aurora_parameter_group_family_name = "aurora-postgresql12"

  aurora_maintenance_window      = "Sat:01:00-Sat:03:00"
  aurora_backup_window           = "03:00-04:00"
  aurora_backup_retention_period = 3

  sns_topic_non_critical_arn = "<non-critical sns topic arn>"
  sns_topic_critical_arn     = "<non-critical sns topic arn>"

  providers = {
    aws.default     = aws.default
  }
}
```

### Outputs

```
output "aurora_write_endpoint" {
  value = module.aurora_cluster.aurora_write_endpoint
}

output "aurora_read_endpoint" {
  value = module.aurora_cluster.aurora_read_endpoint
}

output "aurora_server_security_group" {
  value = module.aurora_cluster.aurora_server_security_group
}

output "aurora_client_security_group" {
  value = module.aurora_cluster.aurora_client_security_group
}
```
