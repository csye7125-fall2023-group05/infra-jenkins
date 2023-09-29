module "vpc" {
  source                        = "../modules/vpc"
  region                        = var.region
  vpc_cidr_block                = var.vpc_cidr_block
  env                           = var.env
  public_route_table_cidr_block = var.public_route_table_cidr_block
  public_subnets                = var.public_subnets
  private_subnets               = var.private_subnets
}

module "ec2" {
  source           = "../modules/ec2"
  root_account_ids = var.root_account_ids
  ami_prefix       = var.ami_prefix
  instance_type    = var.instance_type
  public_subnets   = module.vpc.public_subnets
  domain_name      = var.domain_name
  igw_id           = module.vpc.igw_id
  vpc_id           = module.vpc.vpc_id
}
