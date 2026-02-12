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
  iam-prefix      = null==local.basic.iam-prefix?"" : local.basic.iam-prefix
  aws_region      = var.base_config.aws_region
  aws_account_id  = var.base_config.aws_account_id
}

resource "aws_iam_role" "swe_zpes_glue_service_role" {
  name                = "${local.iam-prefix}${local.env}-swe-zpes-glue-service-role"
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole",
    aws_iam_policy.swe_zpes_glue_resource_policy.arn,
  ]
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : [
            "redshift.amazonaws.com",
            "glue.amazonaws.com",
            "ec2.amazonaws.com"
          ]
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_role" "swe_zpes_flink_service_role" {
  name                = "${local.iam-prefix}${local.env}-swe-zpes-flink-service-role"
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/CloudWatchFullAccess",
    aws_iam_policy.swe_zpes_flink_resource_policy.arn,
    aws_iam_policy.swe_zpes_flink_basic_policy.arn
  ]

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "kinesisanalytics.amazonaws.com"
        },
        "Action" : "sts:AssumeRole",
        "Condition" : {
          "StringEquals" : {
            "aws:SourceAccount" : "${local.aws_account_id}"
          },
          "ArnEquals" : {
            "aws:SourceArn" : [
              "arn:aws:kinesisanalytics:${local.aws_region}:${local.aws_account_id}:application/${local.env}_swe_zpes_*"
            ]
          }
        }
      }
    ]
  })
}