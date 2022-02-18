module "vpc" {
	source = "./modules/vpc"

	vpc_name                 = var.vpc_name
	vpc_cidr                 = var.vpc_cidr
	environment				 = var.environment
	public_subnet_cidr_list  = var.public_subnet_cidr_list
	private_subnet_cidr_list = var.private_subnet_cidr_list
	public_subnet_az_list    = ["${var.region}a"]
	private_subnet_az_list   = ["${var.region}b"]
}