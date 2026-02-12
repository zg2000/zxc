output "redshift_security_group_id" {
  value = module.redshift_instance.security_group_id
}

output "redshift_cluster_arn" {
  value = module.redshift_instance.arn
}
output "redshift_cluster_identifier" {
  value = module.redshift_instance.cluster_identifier
}
output "redshift_cluster_endpoint" {
  value = module.redshift_instance.endpoint
}
output "redshift_cluster_port" {
  value = try(local.redshift_config.port, 5439)
}
output "redshift_cluster_username" {
  value = local.root_user
}
output "redshift_cluster_password" {
  value = local.root_password
  sensitive = true
}
