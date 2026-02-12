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

  zpes_flink_s3_arn = var.zpes_flink_s3_arn

  m241-log-metadata      = try(local.yaml-config-data.flink.m241-log-metadata, {})
  m241-file-metadata      = try(local.yaml-config-data.flink.m241-file-metadata, {})

  zxcKafkaBootstrapServers = null
  zxcInputKafkaGroupId = null
  zxcInputKafkaTopic = null

}

resource "aws_cloudwatch_log_group" "zpes_flink_log_group" {
  name = "/aws/swe-zpes-flink-log-group"
  tags = var.tags
}

resource "aws_security_group" "zpes_flink_sg" {
  name        = "${local.env}-swe-zpes-flink-sg"
  description = "${local.env}-swe-zpes-flink-sg"
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

module "zpes_m241_log_metadata_job" {
  source = "../../../private-modules/aws-flink"
  create = try(local.m241-log-metadata.create, false)
  name   = "${local.env}_swe_zpes_m241_log_metadata_job"

  runtime_environment = try(local.m241-log-metadata.config.runtime_environment, "FLINK-1_15")

  service_execution_role = var.swe_zpes_flink_service_role_arn

  create_cloudwatch_log_group = false
  cloudwatch_log_group_name   = aws_cloudwatch_log_group.zpes_flink_log_group.name
  #vpc
  vpc_id                      = var.vpc_id
  private_subnet_ids          = var.private_subnet_ids
  create_security_group       = false
  vpc_security_group_ids      = [aws_security_group.zpes_flink_sg.id, var.rds_security_group_id]

  code_config = {
    bucket_arn        = var.zpes_flink_s3_arn
    file_key          = "flink-jars/flink-metric-trace-1.1-SNAPSHOT.jar"
    code_content_type = "ZIPFILE"
  }

  parallelism_config = {
    configuration_type   = "CUSTOM"
    auto_scaling_enabled = false
    parallelism          = 20
    parallelism_per_kpu  = 4
  }

  #property
  property_group_id = "group"
  property_map      = {
    "inputKafkaBootstrapServers": try(local.m241-log-metadata.config.inputKafkaBootstrapServers)
    "inputKafkaGroupId": try(local.m241-log-metadata.config.inputKafkaGroupId)
    "inputKafkaTopic": try(local.m241-log-metadata.config.inputKafkaTopic)

    "jdbcDriverClassName": "com.mysql.jdbc.Driver",
    "jdbcMybatisMapperPackageName": "com.zeekr.zpes.flink.trace.mapper",
    "jdbcUrl": var.vehicleJdbcUrl,

    "ossBucketName": var.ossBucketName,

    "outputKafkaBootstrapServers": var.zpesKafkaBootstrapServers,
    "outputKafkaTopic": var.kafkaTopicOfLogMetadata,

    "secretIds": "${local.env}/swe/zpes/config"
  }

  tags = var.tags
}

module "zpes_m241_file_metadata_job" {
  source = "../../../private-modules/aws-flink"
  create = try(local.m241-file-metadata.create, false)
  name   = "${local.env}_swe_zpes_m241_file_metadata_job"

  runtime_environment = try(local.m241-file-metadata.config.runtime_environment, "FLINK-1_15")

  service_execution_role = var.swe_zpes_flink_service_role_arn

  create_cloudwatch_log_group = false
  cloudwatch_log_group_name   = aws_cloudwatch_log_group.zpes_flink_log_group.name
  #vpc
  vpc_id                      = var.vpc_id
  private_subnet_ids          = var.private_subnet_ids
  create_security_group       = false
  vpc_security_group_ids      = [aws_security_group.zpes_flink_sg.id, var.rds_security_group_id]

  code_config = {
    bucket_arn        = var.zpes_flink_s3_arn
    file_key          = "flink-jars/m241_file_metadata-1.0-SNAPSHOT.jar"
    code_content_type = "ZIPFILE"
  }

  parallelism_config = {
    configuration_type   = "CUSTOM"
    auto_scaling_enabled = false
    parallelism          = 20
    parallelism_per_kpu  = 4
  }

  #property
  property_group_id = "group"
  property_map      = {
    "inputKafkaBootstrapServers": try(local.m241-file-metadata.config.inputKafkaBootstrapServers)
    "inputKafkaGroupId": try(local.m241-file-metadata.config.inputKafkaGroupId)
    "inputKafkaTopic": try(local.m241-file-metadata.config.inputKafkaTopic)

    "jdbcDriverClassName": "com.mysql.jdbc.Driver",
    "jdbcMybatisMapperPackageName": "com.zeekr.zpes.flink.trace.mapper",
    "jdbcUrl": var.zpesJdbcUrl,

    "ossBucketName": var.ossBucketName,
    "outputKafkaBootstrapServers": var.zpesKafkaBootstrapServers,
    "outputKafkaTopic": var.kafkaTopicOfFileMetadata,

    "secretIds": "${local.env}/swe/zpes/config"
  }

  tags = var.tags
}