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
  sqs_arn            = var.sqs_arn
  s3_arn             = var.s3_arn
}

data "aws_s3_bucket_object" "application_zip" {
  bucket = var.aws_zxc_lambda_s3_bucket
  key    = "lambda-jars/s3-trigger-lambda-1.0.0-EU-RELEASE.jar"
}

resource "aws_cloudwatch_log_group" "zxc_lambda_log_group" {
  name = "/aws/lambda/aws-zxc-eu-uat-s3-trigger-lambda"
  tags = var.tags
  retention_in_days = 7
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_security_group" "zxc_lambda_sg" {
  name        = "${local.env}-aws-zxc-lambda-sg"
  description = "${local.env}-aws-zxc-lambda-sg"
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


resource "aws_lambda_function" "zxc_s3_trigger_lambda" {
  function_name = "${local.resource-prefix}-${local.env}-s3-trigger-lambda"
  role          = var.zxc_lambda_role_arn
  architectures = ["arm64"]
  s3_bucket         = var.aws_zxc_lambda_s3_bucket
  s3_key            = data.aws_s3_bucket_object.application_zip.key
  handler           = "com.zeekr.zxc.s3.trigger.SQSTriggerHandler"
  runtime           = "java8.al2"
  memory_size       = 512
  description       = "${local.env} Lambda created by Terraform"
  s3_object_version = data.aws_s3_bucket_object.application_zip.version_id

  tracing_config {
    mode = "Active"
  }
  # Every subnet should be able to reach an EFS mount target in the same Availability Zone. Cross-AZ mounts are not permitted.
  vpc_config {
    subnet_ids         = local.private_subnet_ids
    security_group_ids = [aws_security_group.zxc_lambda_sg.id]
  }
  environment {
    variables = {
      AWS_LAMBDA_JAVA_NETWORKADDRESS_CACHE_NEGATIVE_TTL = "0",
      BUCKET_NAME = var.aws_zxc_s3_data_bucket_name,
      ENDPOINT = "https://s3.eu-central-1.amazonaws.com",
      KEY_SERIALIZER = "org.apache.kafka.common.serialization.StringSerializer",
      PRODUCER_ACKS = "-1",
      PRODUCER_BATCH_NUM_MESSAGE = "1000",
      PRODUCER_BATCH_SIZE = "16384",
      PRODUCER_BOOTSTRAP = var.front_kafka_bootstrap_brokers
      PRODUCER_LINGER_MS = "0",
      PRODUCER_MESSAGE_MAX_BYTES = "8388608",
      PRODUCER_TOPIC = "edge_alg_oss_notify_prod_interal_topic",
      REGION = var.base_config.aws_region,
      REQUEST_TIMEOUT_MS = "60000",
      VALUE_SERIALIZER = "org.apache.kafka.common.serialization.StringSerializer",
      VDP_KEY_SERIALIZER = "org.apache.kafka.common.serialization.StringSerializer"
      VDP_PRODUCER_ACKS = "-1",
      VDP_PRODUCER_BATCH_NUM_MESSAGES = "1000",
      VDP_PRODUCER_BATCH_SIZE = "16384",
      VDP_PRODUCER_BOOTSTRAP = var.vdp_front_kafka_brokers,
      VDP_PRODUCER_LINGER_MS = "0",
      VDP_PRODUCER_MESSAGE_MAX_BYTES = "8388608",
      VDP_PRODUCER_TOPIC = "vdp_edge_alg_oss_notify_prod_topic",
      VDP_REQUEST_TIMEOUT_MS = "60000",
      VDP_VALUE_SERIALIZER = "org.apache.kafka.common.serialization.StringSerializer"


    }
  }

  timeout = 300
}

resource "aws_lambda_event_source_mapping" "zxc_s3_trigger_lambda_sqs_source" {
  event_source_arn = var.aws_zxc_s3_data_sqs_arn
  function_name    = aws_lambda_function.zxc_s3_trigger_lambda.arn

}

