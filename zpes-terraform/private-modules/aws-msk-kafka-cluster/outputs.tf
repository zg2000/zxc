output "security_group_id" {
  value = try(local.security_groups[0], null)
}

output "arn" {
  value = try(aws_msk_cluster.this[0].arn, null)
}

output "bootstrap_brokers" {
  value = try( aws_msk_cluster.this[0].bootstrap_brokers, null)
}

output "security_groups" {
  value = local.security_groups
}

