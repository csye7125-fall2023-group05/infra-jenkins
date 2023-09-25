module "vpc" {
  source                        = "../modules/vpc"
  region                        = var.region
  vpc_cidr_block                = var.vpc_cidr_block
  env                           = var.env
  public_route_table_cidr_block = var.public_route_table_cidr_block
  public_subnets                = var.public_subnets
  private_subnets               = var.private_subnets
}
