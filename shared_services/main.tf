module "vpc" {
  source = "../modules/vpc" # This points to your factory

  # Passing the variables into the module
  region             = "us-east-1"
  vpc_cidr           = var.vpc_cidr
  project_name       = var.project_name
  environment        = var.environment
  availability_zones = var.availability_zones
}

