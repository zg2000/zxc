output "redis_security_group_id" {
  value = module.data_redis_instance.security_group_id
}

output "redis_arn" {
  value = module.data_redis_instance.arn
}

output "redis_endpoint" {
  value = module.data_redis_instance.endpoint
}

output "redis_pwd" {
  value     = module.password.root_password
  sensitive = true
}
output "redis_password" {
  value     = local.root_password
  sensitive = true
}