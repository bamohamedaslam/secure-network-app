resource "aws_vpc" "vpc" {
	cidr_block           = var.vpc_cidr
	enable_dns_hostnames = true
	tags = {
		Name = "${var.vpc_name}"
	}
}

resource "aws_subnet" "public_subnet" {
	count                   = length(var.public_subnet_cidr_list)
	vpc_id                  = aws_vpc.vpc.id
	cidr_block              = element(var.public_subnet_cidr_list, count.index)
	availability_zone       = element(var.public_subnet_az_list, count.index)
	map_public_ip_on_launch = "true"
	tags = {
		Name = "${var.vpc_name}-Public-Subnet-${count.index + 1}"
	}
}

resource "aws_internet_gateway" "internet_gateway" {
	count  = (length(var.public_subnet_cidr_list) > 0) ? 1 : 0
	vpc_id = aws_vpc.vpc.id
	tags = {
		Name = "${var.vpc_name}-Internet-Gateway"
	}
}

resource "aws_route_table" "public_route_table" {
	count 	= (length(var.public_subnet_cidr_list) > 0) ? 1 : 0
	vpc_id 	= aws_vpc.vpc.id
	tags = {
		Name = "${var.vpc_name}-Public-Route-Table"
	}
}

resource "aws_route" "public_route" {
	count                  = (length(var.public_subnet_cidr_list) > 0) ? 1 : 0
	route_table_id         = aws_route_table.public_route_table[count.index].id
	destination_cidr_block = "0.0.0.0/0"
	gateway_id             = aws_internet_gateway.internet_gateway[count.index].id
}

resource "aws_route_table_association" "public_subnet_route_table_association" {
	count          = length(var.public_subnet_cidr_list)
	subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
	route_table_id = element(aws_route_table.public_route_table.*.id, count.index)
}


resource "aws_eip" "nat_elastic_ip" {
	count      = (length(var.public_subnet_cidr_list) > 0) ? 1 : 0
	vpc        = true
	depends_on = [aws_internet_gateway.internet_gateway]
}

resource "aws_nat_gateway" "nat_gateway" {
	count         	= (length(var.public_subnet_cidr_list) > 0) ? 1 : 0
	allocation_id 	= element(aws_eip.nat_elastic_ip.*.id, count.index)
	subnet_id  		= element(aws_subnet.public_subnet.*.id, count.index)
	depends_on 		= [aws_internet_gateway.internet_gateway]
	tags = {
		Name = "${var.vpc_name}-NAT"
	}
}

resource "aws_subnet" "private_subnet" {
	count             = length(var.private_subnet_cidr_list)
	vpc_id            = aws_vpc.vpc.id
	cidr_block        = element(var.private_subnet_cidr_list, count.index)
	availability_zone = element(var.private_subnet_az_list, count.index)
	tags = {
		Name = "${var.vpc_name}-Private-Subnet-${count.index + 1}"
	}
}

resource "aws_route_table" "private_route_table" {
	count 	= (length(var.public_subnet_cidr_list) > 0) ? 1 : 0
	vpc_id 	= aws_vpc.vpc.id
	tags = {
		Name = "${var.vpc_name}-Private-Route-Table"
	}
}

resource "aws_route" "private_route" {
	count                  = (length(var.private_subnet_cidr_list) > 0) ? 1 : 0
	route_table_id         = aws_route_table.private_route_table[count.index].id
	destination_cidr_block = "0.0.0.0/0"
	gateway_id             = aws_nat_gateway.nat_gateway[count.index].id
}

resource "aws_route_table_association" "private_subnet_route_table_association" {
	count          = length(var.private_subnet_cidr_list)
	subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
	route_table_id = element(aws_route_table.private_route_table.*.id, count.index)
}
