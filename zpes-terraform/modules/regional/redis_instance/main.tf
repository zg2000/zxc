provider "aws" {
  region = var.base_config.aws_region
}

data "local_file" "config_file" {
  filename = var.base_config.local_yaml_file_name
}
module "password" {
  source = "../../../private-modules/password"
  length = 20
}

locals {
  env              = var.base_config.env
  yaml-config-data = yamldecode(data.local_file.config_file.content)

  basic           = local.yaml-config-data.basic
  resource-prefix = local.basic.resource-prefix

  redis = try(local.yaml-config-data.redis, {})

  ## redis config
  vpc_id             = var.vpc_id
  private_subnet_ids = var.private_subnet_ids
  root_password      = module.password.root_password

  create                      = try(local.redis.create, false)
  private-subnet-group-name   = try(local.redis.private-subnet-group, false)
  create-private-subnet-group = try(local.redis.create-private-subnet-group, false)

}

resource "aws_elasticache_subnet_group" "this" {
  count      = local.create&& local.create-private-subnet-group  ?1 : 0
  name       = local.private-subnet-group-name
  subnet_ids = local.private_subnet_ids
  lifecycle {
    ignore_changes = all
  }
}


locals {
  db_subnet_group_name = local.create-private-subnet-group? aws_elasticache_subnet_group.this[0].name : try(local.redis.private-subnet-group, null)
  redis_config         = try(local.redis.config, {})

  infix_name = try(local.redis_config.infix_name, "cache")
}


module "data_redis_instance" {
  source = "../../../private-modules/aws-redis"
  create = local.create

  ##basic info
  name                       = "${local.resource-prefix}-${local.infix_name}-${local.env}-redis"
  port                       = try(local.redis_config.port, 6379)
  automatic_failover_enabled = try(local.redis_config.automatic_failover_enabled, true)
  multi_az_enabled           = try(local.redis_config.multi_az_enabled, true)
  auto_minor_version_upgrade = try(local.redis_config.auto_minor_version_upgrade, false)
  engine                     = try(local.redis_config.engine, "redis")
  engine_version             = try(local.redis_config.engine_version, "6.2")
  node_type                  = try(local.redis_config.node_type, "cache.t3.small")
  num_cache_clusters         = try(local.redis_config.num_cache_clusters, 2)
  password                   = module.password.root_password
  create_parameter_group     = try(local.redis_config.create_parameter_group, true)
  parameter_group_family     = try(local.redis_config.parameter_group_family, "redis6.x")

  #vpc
  vpc_id             = local.vpc_id
  private_subnet_ids = local.private_subnet_ids
  subnet_group_name  = local.db_subnet_group_name

  create_security_group       = true
  create_cloudwatch_log_group = try(local.redis_config.create_cloudwatch_log_group, true)

  tags = var.tags
}
