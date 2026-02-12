provider "aws" {
  region = var.base_config.aws_region
}

data "local_file" "config_file" {
  filename = var.base_config.local_yaml_file_name
}

locals {
  env              = var.base_config.env
  yaml-config-data = yamldecode(data.local_file.config_file.content)

  basic              = local.yaml-config-data.basic
  resource-prefix    = local.basic.resource-prefix
  vpc_id             = var.vpc_id
  private_subnet_ids = var.private_subnet_ids

  aws_zxc_flink_s3_arn = var.aws_zxc_flink_s3_arn

  m241-parse = try(local.yaml-config-data.flink.m241-parse, {})

}

resource "aws_cloudwatch_log_group" "zxc_flink_log_group" {
  name = "/aws/zxc-flink-log-group"
  tags = var.tags
}

resource "aws_security_group" "zxc_flink_sg" {
  name        = "${local.env}-aws-zxc-flink-sg"
  description = "${local.env}-aws-zxc-flink-sg"
  vpc_id      = var.vpc_id
  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    self      = true
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.tags
  lifecycle {
    ignore_changes = all
  }
}
#endregion


module "zxc_message_processor" {
  source = "../../../private-modules/aws-flink"
  create = try(local.m241-parse.create, false)
  name   = "${local.env}_aws_zxc_message_processor_job"

  runtime_environment = try(local.m241-parse.config.runtime_environment, "FLINK-1_15")

  service_execution_role = var.aws_zxc_flink_service_role_arn

  create_cloudwatch_log_group = false
  cloudwatch_log_group_name   = aws_cloudwatch_log_group.zxc_flink_log_group.name
  #vpc
  vpc_id                      = var.vpc_id
  private_subnet_ids          = var.private_subnet_ids
  create_security_group       = false
  vpc_security_group_ids      = [aws_security_group.zxc_flink_sg.id]

  code_config = {
    bucket_arn        = var.aws_zxc_flink_s3_arn
    file_key          = "flink-jars/message-processor-eu-1.1.3.jar"
    code_content_type = "ZIPFILE"
  }

  parallelism_config = {
    configuration_type   = "CUSTOM"
    auto_scaling_enabled = false
    parallelism          = 80
    parallelism_per_kpu  = 4
  }

  #property
  property_group_id = "group"
  property_map      = {
    env                        = "${local.env}"
    minPauseBetweenCheckpoints = "1000"
    enableCheckpointing        = "60000"
    stateTtlTime               = "345600"
    mustLargeTime              = "24"
    mustDelayTime              = "10800"
    maxPollCount               = "60000"
    heartbeatGroup             = "edge_heart_beat_retry_prod_group"
    heartbeatTopic             = "edge_heart_beat_prod_topic"
    deployGroup                = "edge_deploy_retry_prod_group"
    deployTopic                = "edge_deploy_prod_topic"
    algReportExternalTopic     = "edge_alg_result_prod_topic"
    algReportTopic             = "edge_alg_result_prod_topic"
    retryGroup                 = "edge_retry_message_down_prod_group"
    retryTopic                 = "edge_retry_message_down_prod_topic"
    "serverConsumeConfig"      = "${var.front_kafka_bootstrap_brokers}"
    "serverProducerConfig"     = "${var.back_kafka_bootstrap_brokers}"
    parallelismHeartbeatSource = "2"
    parallelismNotify          = "2"
    parallelismDeployFilter    = "2"
    parallelismProcessor       = "4"
    parallelismProcessorFilter = "4"
    parallelismRetry           = "2"
    parallelismReportFilter    = "2"
    parallelismReportSource    = "2"
    parallelismHeartbeatFilter = "2"
    parallelismRetry           = "2"
  }
  tags = var.tags
}