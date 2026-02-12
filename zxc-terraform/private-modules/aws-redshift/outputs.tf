output "security_group_id" {
  value = try(local.vpc_security_group_ids[0], null)
}

output "arn" {
  value = try(aws_redshift_cluster.this[0].arn, null)
}
output "cluster_identifier" {
  value = try(aws_redshift_cluster.this[0].cluster_identifier, null)
}

output "endpoint" {
  value = try(aws_redshift_cluster.this[0].endpoint, null)
}

output "security_groups" {
  value = local.vpc_security_group_ids
}
