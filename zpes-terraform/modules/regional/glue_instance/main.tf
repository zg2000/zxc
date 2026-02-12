provider "aws" {
  region = var.base_config.aws_region
}

#provider "template" {
#}

data "local_file" "config_file" {
  filename = var.base_config.local_yaml_file_name
}

locals {
  env              = var.base_config.env
  yaml-config-data = yamldecode(data.local_file.config_file.content)

  basic           = local.yaml-config-data.basic
  resource-prefix = local.basic.resource-prefix

  vpc_id                            = var.vpc_id
  private_subnet_ids                = var.private_subnet_ids
  private_subnet_availability_zones = var.private_subnet_availability_zones

  swe_zpes_glue_service_role_arn = var.swe_zpes_glue_service_role_arn
  swe_zpes_glue_s3_bucket        = var.swe_zpes_glue_s3_bucket
  swe_zpes_glue_s3_arn           = var.swe_zpes_glue_s3_arn

#  zpes_m241_log_metadata_to_redshift =
}
##logs
#data "aws_security_group" "vdp_redshift_glue_sg" {
#  name = "aws-vdp-eu-data-${local.env}-redshift-sg"
#}
##resource "aws_security_group" "zpes_glue_sg" {
#  name        = "${local.resource-prefix}-${local.env}-glue-sg"
#  description = "${local.resource-prefix}-${local.env}-glue-sg"
#  vpc_id      = var.vpc_id
#  ingress {
#    from_port = 0
#    to_port   = 65535
#    protocol  = "tcp"
#    self      = true
#  }
#  ingress {
#    from_port       = 22
#    to_port         = 22
#    protocol        = "tcp"
#    security_groups = [data.aws_security_group.vdp_redshift_glue_sg.arn]
#  }
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#  tags = var.tags
#  lifecycle {
#    ignore_changes = all
#  }
#}
## connection
resource "aws_glue_connection" "swe_zpes_network" {
  name            = "${local.resource-prefix}-${local.env}-network"
  connection_type = "NETWORK"
  physical_connection_requirements {
    availability_zone      = local.private_subnet_availability_zones[0]
    subnet_id              = local.private_subnet_ids[0]
    security_group_id_list = [aws_security_group.zpes_glue_sg.id]
  }
}
## dependent
resource "aws_s3_object" "spark_kafka_offset_committer" {
  bucket = local.swe_zpes_glue_s3_bucket
  key    = "/glue/dependent/spark3.3-sql-kafka-offset-committer-1.0.jar"
  source = "${path.module}/dependent/spark3.3-sql-kafka-offset-committer-1.0.jar"
}

locals {
  tempDir                    = "s3://${local.swe_zpes_glue_s3_bucket}/glue/temporary/"
  extra-jars                 = "s3://${local.swe_zpes_glue_s3_bucket}${aws_s3_object.spark_kafka_offset_committer.key}"
  event-logs-path            = "s3://${local.swe_zpes_glue_s3_bucket}/glue/sparkHistoryLogs/"
  checkpoint-location-prefix = "s3://${local.swe_zpes_glue_s3_bucket}/glue/checkpoint"

#  m241-zpes-all-data = try(local.yaml-config-data.glue.m241-zpes-all-data, {})
#  m241-zpes-raw-body = try(local.yaml-config-data.glue.m241-zpes-raw-body, {})
}
