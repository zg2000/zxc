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
}

##region glue sg rule
resource "aws_security_group_rule" "swe_zpes_glue_front_msk_rule" {
  count                    = local.create-front-kafka?1 : 0
  source_security_group_id = var.swe_zpes_glue_sg_id
  type                     = "ingress"
  security_group_id        = var.swe_zpes_front_msk_sg_id
  to_port                  = 9092
  from_port                = 9092
  protocol                 = "TCP"
  description              = "Glue Access"
}

##endregion

##region flink sg rule


##endregion

##region eks sg rule
##endregion
