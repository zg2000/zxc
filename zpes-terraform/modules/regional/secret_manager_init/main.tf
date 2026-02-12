provider "aws" {
  region = var.base_config.aws_region
}

data "local_file" "config_file" {
  filename = var.base_config.local_yaml_file_name
}

locals {
  env              = var.base_config.env
  yaml-config-data = yamldecode(data.local_file.config_file.content)
}

resource "aws_secretsmanager_secret" "swe_zpes_config" {
  name        = "${local.env}/swe/zpes/config"
  description = "zpes component config:glue/kda..."
  tags        = var.tags
}


resource "aws_secretsmanager_secret_version" "swe_zpes_config_secret" {
  secret_id     = aws_secretsmanager_secret.swe_zpes_config.id
  secret_string = var.secret_string

  lifecycle {
    ignore_changes = all
  }
}

