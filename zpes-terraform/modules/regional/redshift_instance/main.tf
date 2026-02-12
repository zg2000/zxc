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

  redshift = try(local.yaml-config-data.redshift, {})

  ##config
  vpc_id             = var.vpc_id
  private_subnet_ids = var.private_subnet_ids
  root_user          = var.zeekr_root_user
  root_password      = module.password.root_password

  create                      = try(local.redshift.create, false)
  create-private-subnet-group = try(local.redshift.create-private-subnet-group, false)
}

resource "aws_redshift_subnet_group" "this" {
  count      = local.create&& local.create-private-subnet-group  ?1 : 0
  name       = "${local.env}-redshift-private-subnet-group"
  subnet_ids = local.private_subnet_ids
  lifecycle {
    ignore_changes = all
  }
}

locals {
  subnet_group_name = local.create&&  local.create-private-subnet-group? aws_redshift_subnet_group.this[0].name : try(local.redshift.private-subnet-group, null)
  redshift_config   = try(local.redshift.config, {})

  infix_name = try(local.redshift_config.infix_name, "data")
}

module "redshift_instance" {
  source = "../../../private-modules/aws-redshift"
  create = local.create

  ##basic info
  cluster_identifier = "${local.resource-prefix}-${local.infix_name}-${local.env}-redshift"
  database_name      = local.redshift_config.database_name
  port               = try(local.redshift_config.port, 5439)
  username           = local.root_user
  password           = local.root_password

  snapshot_cluster_identifier = try(local.redshift_config.snapshot_cluster_identifier, null)
  snapshot_identifier         = try(local.redshift_config.snapshot_identifier, null)
  skip_final_snapshot         = try(local.redshift_config.skip_final_snapshot, true)
  final_snapshot_identifier   = try(local.redshift_config.final_snapshot_identifier, null)
  node_type                   = try(local.redshift_config.node_type, null)
  number_of_nodes             = try(local.redshift_config.number_of_nodes, null)
  create_parameter_group      = try(local.redshift_config.create_parameter_group, true)

  #vpc
  vpc_id             = local.vpc_id
  private_subnet_ids = local.private_subnet_ids
  subnet_group_name  = local.subnet_group_name

  encrypted = try(local.redshift_config.encrypted, true)

  tags = var.tags
}
