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

  mysql = try(local.yaml-config-data.mysql_job, {})

  ##rds config
  vpc_id             = var.vpc_id
  private_subnet_ids = var.private_subnet_ids
  root_user          = var.zeekr_root_user
  root_password      = module.password.root_password

  create                      = try(local.mysql.create, false)
  create-private-subnet-group = try(local.mysql.create-private-subnet-group, false)

}

resource "aws_db_subnet_group" "this" {
  count      = local.create&& local.create-private-subnet-group  ?1 : 0
  name       = "${local.env}-rds-private-subnet-group"
  subnet_ids = var.private_subnet_ids
  lifecycle {
    ignore_changes = all
  }
}
locals {
  db_subnet_group_name = local.create&&  local.create-private-subnet-group? aws_db_subnet_group.this[0].name : try(local.mysql.private-subnet-group, null)
  mysql_config         = try(local.mysql.config, {})

  infix_name = try(local.mysql_config.infix_name, "data")
}

module "data_rds_instance" {
  source = "../../../private-modules/aws-rds"
  create = local.create

  ##basic info
  identifier        = "${local.resource-prefix}-${local.infix_name}-${local.env}-mysql"
  engine            = try(local.mysql_config.engine, "mysql")
  engine_version    = try(local.mysql_config.engine_version, "8.0.35")
  instance_class    = try(local.mysql_config.instance_class, "db.m5.large")
  allocated_storage = try(local.mysql_config.allocated_storage, 100)
  db_name           = try(local.mysql_config.db_name, "zpes")
  username          = local.root_user
  password          = local.root_password

  vpc_id                 = local.vpc_id
  private_subnet_ids     = local.private_subnet_ids
  create_parameter_group = true
  parameter_group_family = try(local.mysql_config.parameter_group_family, "mysql8.0")

  db_subnet_group_name = local.db_subnet_group_name

  create_security_group = true
  multi_az              = false

  backup_retention_period         = try(local.mysql_config.backup_retention_period, 7)
  enabled_cloudwatch_logs_exports = try(local.mysql_config.enabled_cloudwatch_logs_exports, [
    "audit", "error", "general", "slowquery"
  ])

  tags = var.tags
}