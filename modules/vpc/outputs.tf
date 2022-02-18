output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.*.id
}

output "public_subnet_cidr" {
  value = aws_subnet.public_subnet.*.cidr_block
}

output "public_rt_id" {
  value = aws_route_table.public_route_table.*.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.*.id
}

output "private_subnet_cidr" {
  value = aws_subnet.private_subnet.*.cidr_block
}

output "private_rt_id" {
  value = aws_route_table.private_route_table.*.id
}

output "nat_gw_id" {
  value = aws_nat_gateway.nat_gateway.*.id
}
