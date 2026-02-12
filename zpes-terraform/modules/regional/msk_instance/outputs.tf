output "front_msk_security_group_id" {
  value = module.front_msk_instance.security_group_id
}

output "front_msk_arn" {
  value = module.front_msk_instance.arn
}

output "front_msk_bootstrap_brokers" {
  value = module.front_msk_instance.bootstrap_brokers
}