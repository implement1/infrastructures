terraform {
  backend "s3" {
    encrypt = true
    key     = "terraform.tfstate"
  }

  required_providers {
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.66.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.2.0"
    }
  }

  required_version = "~> 1.0.7"
}

provider "aws" {
  region = var.aws_region

  alias = "default"
}
