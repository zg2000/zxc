output "default_vpc_id" {
  value = data.aws_vpc.default_vpc.id
}


output "private_subnet_ids" {
  value = [for val in local.private-az-list :  data.aws_subnet.private_subnet[val].id]
}
output "private_subnet_availability_zones" {
  value = [for val in local.private-az-list :  data.aws_subnet.private_subnet[val].availability_zone]
}

output "public_subnet_ids" {
  value = [for val in local.public-az-list :  data.aws_subnet.public_subnet[val].id]
}