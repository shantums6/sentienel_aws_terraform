variable "vpc_cidr" {}
variable "project_name" {}
variable "environment" {}

variable "region" {
  type        = string
  description = "The AWS region to deploy resources into"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of AZs to use for subnets"
}
