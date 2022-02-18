output "vpc_cidr" {
  value = module.vpc.vpc_cidr
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnet_id_list" {
  value = module.vpc.private_subnet_id_list
}

output "public_subnet_id_list" {
  value = module.vpc.public_subnet_id_list
}
