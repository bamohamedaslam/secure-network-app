# Environment
variable "environment" {
  	type = string
}

# VPC resource name
variable "vpc_name" {
  	type = string
}

# VPC resource name
variable "region" {
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

# Private Subnet CIDR
variable "private_subnet_cidr_list" {
	type = list(string)
}

variable "app_ami_id" {
  type = string
}

variable "app_volume_size" {
  type = string
}

variable "key_pair_name" {
  type = string
}

variable "app_instance_type" {
  type = string
}

variable "app_instance_count" {
  type = string
}

variable "vm_type" {
  type = string
}