output "front_msk_security_group_id" {
  value = module.front_msk_instance.security_group_id
}

output "front_msk_arn" {
  value = module.front_msk_instance.arn
}

output "front_msk_bootstrap_brokers" {
  value = module.front_msk_instance.bootstrap_brokers
}


output "back_msk_security_group_id" {
  value = try(local.back-kafka.create, false) ?  module.back_msk_instance.security_group_id : module.front_msk_instance.security_group_id
}

output "back_msk_arn" {
  value = try(local.back-kafka.create, false) ?   module.back_msk_instance.arn : module.front_msk_instance.arn
}

output "back_msk_bootstrap_brokers" {
  value = try(local.back-kafka.create, false) ?module.back_msk_instance.bootstrap_brokers : module.front_msk_instance.bootstrap_brokers
}
