output "security_group_id" {
  value = try(local.vpc_security_group_ids[0], null)
}
output "arn" {
  value = try(aws_db_instance.this[0].arn, null)
}
output "endpoint" {
  value = try( aws_db_instance.this[0].endpoint, null)
}
output "address" {
  value = try( aws_db_instance.this[0].address, null)
}
output "port" {
  value = try( aws_db_instance.this[0].port, null)
}

output "security_groups" {
  value = local.vpc_security_group_ids
}

