provider "aws" {
  region = var.base_config.aws_region
}

data "local_file" "config_file" {
  filename = var.base_config.local_yaml_file_name
}

locals {
  env              = var.base_config.env
  yaml-config-data = yamldecode(data.local_file.config_file.content)
  vpc-name         = local.yaml-config-data.vpc.name

  private-az-list = local.yaml-config-data.vpc.private-az-list
  public-az-list  = local.yaml-config-data.vpc.public-az-list
}

data "aws_vpc" "default_vpc" {
  tags = {
    Name = local.vpc-name
  }
}

data "aws_subnet" "private_subnet" {
  for_each = toset(local.private-az-list)
  filter {
    name   = "tag:Name"
    values = [each.value]
  }
}

data "aws_subnet" "public_subnet" {
  for_each = toset(local.public-az-list)
  filter {
    name   = "tag:Name"
    values = [each.value]
  }
}