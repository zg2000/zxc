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
#
#resource "aws_iam_role" "zxc_glue_service_role" {
#  name                = "${local.iam-prefix}${local.env}-zxc-glue-service-role"
#  managed_policy_arns = [
#    "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole",
#    aws_iam_policy.zxc_glue_resource_policy.arn,
#  ]
#  assume_role_policy = jsonencode({
#    "Version" : "2012-10-17",
#    "Statement" : [
#      {
#        "Effect" : "Allow",
#        "Principal" : {
#          "Service" : [
#            "redshift.amazonaws.com",
#            "glue.amazonaws.com",
#            "ec2.amazonaws.com"
#          ]
#        },
#        "Action" : "sts:AssumeRole"
#      }
#    ]
#  })
#}


resource "aws_iam_role" "zxc_flink_service_role" {
  name                = "${local.iam-prefix}${local.env}-zxc-flink-service-role"
  managed_policy_arns = [
    aws_iam_policy.zxc_flink_resource_policy.arn,
    "arn:aws:iam::aws:policy/AmazonVPCFullAccess",
    "arn:aws:iam::aws:policy/CloudWatchFullAccess"
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
              "arn:aws:kinesisanalytics:${local.aws_region}:${local.aws_account_id}:application/${local.env}_aws_zxc_*"
            ]
          }
        }
      }
    ]
  })
}

resource "aws_iam_role" "zxc_lambda_service_role" {
  name                = "${local.iam-prefix}${local.env}-zxc-lambda-service-role"
  managed_policy_arns = [
    aws_iam_policy.zxc_lambda_resource_policy.arn,
    "arn:aws:iam::aws:policy/CloudWatchLambdaInsightsExecutionRolePolicy"
  ]

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

}