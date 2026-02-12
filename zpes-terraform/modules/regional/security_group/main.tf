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
#
#resource "aws_security_group" "aws_zd_zpes_flink_sg" {
#  name        = "aws_zd_zpes_${local.env}_flink_sg"
#  description = "security group for zpes flink"
#  vpc_id      = var.vpc_id
#  tags        = var.tags
#}

#
#resource "aws_security_group_rule" "inbound_rule" {
#  security_group_id        = aws_security_group.example.id
#  type                     = "ingress"
#  from_port                = 0
#  to_port                  = 0
#  protocol                 = "-1"
#  source_security_group_id = aws_security_group.other.id
#}