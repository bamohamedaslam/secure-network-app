# Environment
variable "environment" {
  	type = string
}

# VPC resource name
variable "vpc_name" {
  	type = string
}

# VPC CIDR
variable "vpc_cidr" {
	type = string
}

# Public Subnet CIDR
variable "public_subnet_cidr_list" {
	type = list(string)
}

# Public Subnet AZs
variable "public_subnet_az_list" {
	type = list(string)
}

# Private Subnet CIDR
variable "private_subnet_cidr_list" {
	type = list(string)
}

# Private Subnet AZs
variable "private_subnet_az_list" {
  	type = list(string)
}
