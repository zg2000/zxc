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

  aws_region     = var.base_config.aws_region
  aws_account_id = var.base_config.aws_account_id
}


resource "aws_sqs_queue" "swe_zpes_s3_data_sqs" {
  name = "${local.env}_swe_zpes_s3_data_sqs"

  visibility_timeout_seconds = 30
  message_retention_seconds  = 60
  delay_seconds              = 0
  max_message_size           = 262144
  receive_wait_time_seconds  = 10

  tags = var.tags
}

resource "aws_sqs_queue_policy" "swe_zpes_zxc_data_sqs_policy" {
  queue_url = aws_sqs_queue.swe_zpes_s3_data_sqs.id
  policy    = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "s3.amazonaws.com"
          },
          "Action" : [
            "SQS:SendMessage"
          ],
          "Resource" : aws_sqs_queue.swe_zpes_s3_data_sqs.arn,
          "Condition" : {
            "ArnLike" : {
              "aws:SourceArn" : "${var.swe_zpes_data_s3_arn}"
            },
            "StringEquals" : {
              "aws:SourceAccount" : "${local.aws_account_id}"
            }
          }
        }
      ]
    }
  )
}

