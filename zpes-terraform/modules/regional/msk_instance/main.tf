provider "aws" {
  region = var.base_config.aws_region
}

data "local_file" "config_file" {
  filename = var.base_config.local_yaml_file_name
}

locals {
  env              = var.base_config.env
  yaml-config-data = yamldecode(data.local_file.config_file.content)

  basic           = local.yaml-config-data.basic
  resource-prefix = local.basic.resource-prefix

  zpes_msk_logs_s3_bucket = var.zpes_msk_logs_s3_bucket

  front-kafka = try(local.yaml-config-data.kafka.front, {})

  vpc_id             = var.vpc_id
  private_subnet_ids = var.private_subnet_ids
}


module "front_msk_instance" {
  source = "../../../private-modules/aws-msk-kafka-cluster"
  create = try(local.front-kafka.create, false)
  tags   = var.tags

  name = "${local.resource-prefix}-internal-${local.env}-kafka"

  kafka_version              = try(local.front-kafka.config.kafka_version, "2.8.1")
  number_of_broker_nodes     = try(local.front-kafka.config.number_of_broker_nodes, null)
  enhanced_monitoring        = try(local.front-kafka.config.enhanced_monitoring, "PER_TOPIC_PER_PARTITION")
  broker_node_client_vpc_id  = local.vpc_id
  broker_node_client_subnets = local.private_subnet_ids
  broker_node_instance_type  = try(local.front-kafka.config.broker_node_instance_type, "kafka.t3.small")
  storage_volume_size        = try(local.front-kafka.config.storage_volume_size, 100)

  s3_logs_enabled = true
  s3_logs_bucket  = local.zpes_msk_logs_s3_bucket
  s3_logs_prefix  = "logs/front-msk-logs"

  create_configuration            = try(local.front-kafka.config.create_configuration, false)
  configuration_server_properties = try(local.front-kafka.config.configuration_server_properties, null)
}