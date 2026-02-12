provider "aws" {
  region = var.base_config.aws_region
}

data "local_file" "config_file" {
  filename = var.base_config.local_yaml_file_name
}

locals {
  env              = var.base_config.env
  yaml-config-data = yamldecode(data.local_file.config_file.content)

  create-front-kafka = try(local.yaml-config-data.kafka.front.create, false)
  create-back-kafka  = try(local.yaml-config-data.kafka.back.create, false)
}

##region kafka sg rule --internal
resource "aws_security_group_rule" "zxc_flink_front_msk_rule" {
  count                    = local.create-front-kafka?1 : 0
  source_security_group_id = var.zxc_flink_sg_id
  type                     = "ingress"
  security_group_id        = var.zxc_front_msk_sg_id
  to_port                  = 9092
  from_port                = 9092
  protocol                 = "TCP"
  description              = "Flink Access"
}
resource "aws_security_group_rule" "zxc_lambda_rule" {
  count                    = local.create-back-kafka?1 : 0
  source_security_group_id = var.zxc_lambda_sg_id
  type                     = "ingress"
  security_group_id        = var.zxc_back_msk_sg_id
  to_port                  = 9092
  from_port                = 9092
  protocol                 = "TCP"
  description              = "lambda Access"
}

//vdp
resource "aws_security_group_rule" "zxc_lambda_vdp_rule" {
  count                    = local.create-front-kafka?1 : 0
  source_security_group_id = var.zxc_lambda_sg_id
  type                     = "ingress"
  security_group_id        = var.vdp_front_msk_sg_id
  to_port                  = 9092
  from_port                = 9092
  protocol                 = "TCP"
  description              = "Lambda access vdp"
}

  ##region kafka sg rule --external
  resource "aws_security_group_rule" "zxc_flink_back_msk_rule" {
    count                    = local.create-back-kafka?1 : 0
    source_security_group_id = var.zxc_back_msk_sg_id
    type                     = "ingress"
    security_group_id        = var.zxc_flink_sg_id
    to_port                  = 9092
    from_port                = 9092
    protocol                 = "TCP"
    description              = "Flink out"
  }