module "vpc" {
  # This tells Terraform where the blueprint lives
  source = "../../modules/vpc"

  # Here we pass the Dev values into the blueprint
  vpc_name             = var.vpc_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
}
