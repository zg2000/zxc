output "security_group_id" {
  value = try(local.vpc_security_group_ids[0], null)
}

output "arn" {
  value = try(  aws_elasticache_replication_group.this[0].arn, null)
}

output "endpoint" {
  value = try(aws_elasticache_replication_group.this[0].primary_endpoint_address, null)
}

output "security_groups" {
  value = local.vpc_security_group_ids
}
