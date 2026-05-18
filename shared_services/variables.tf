variable "vpc_cidr" {}
variable "project_name" {}
variable "environment" {}

variable "availability_zones" {
  type        = list(string)
  description = "List of AZs for the shared services environment"
}
