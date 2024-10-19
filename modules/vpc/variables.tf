variable "aws_region" {
  type        = string
  description = "aws region to deploy to"
}

variable "application" {
  type        = string
  description = "used for naming resources and tagging"
}

variable "component" {
  type        = string
  description = "used for naming resources and tagging"
  default     = "vpc"
}

variable "environment" {
  type        = string
  description = "used for naming resources and tagging"
}

variable "owner" {
  type        = string
  description = "used for tagging reources"
}

# vpc
variable "vpc_cidr_block" {
  type        = string
  description = "the cidr block to use for the VPC"
}

variable "availability_zones" {
  type        = list(string)
  description = "the list of availability zones to use"
  default     = []
}

variable "subnet_tier_cidrs_newbits" {
  type        = number
  description = "the newbits to use when creating the subnets for the subnet tiers"
  default     = 3
}

variable "public_subnets_cidr_newbits" {
  type        = number
  description = "the newbits to use for creating subnets for the public subnets"
  default     = 7
}

variable "app_subnets_cidr_newbits" {
  type        = number
  description = "the newbits to use for creating subnets for the app subnets"
  default     = 2
}

variable "db_subnets_cidr_newbits" {
  type        = number
  description = "the newbits to use for creating subnets for the db subnets"
  default     = 6
}
