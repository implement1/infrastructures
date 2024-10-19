terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      configuration_aliases = [aws.default]
    }
    random = {
      source = "hashicorp/random"
    }
  }
}
