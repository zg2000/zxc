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

## region
resource "aws_iam_group" "swe_zpes_developer_basic_group" {
  name = "zpes-support-basic-Group"
}
resource "aws_iam_group_policy_attachment" "swe_zpes_developer_basic_group_support_policy_attach" {
  for_each = toset( [
    "arn:aws:iam::aws:policy/AWSSupportAccess",
    "arn:aws:iam::aws:policy/AWSSupportAppFullAccess",
    "arn:aws:iam::aws:policy/job-function/SupportUser"
  ])
  group      = aws_iam_group.swe_zpes_developer_basic_group.name
  policy_arn = each.value
}
##endregion

## region  swe_zpes_developer_rw_group
resource "aws_iam_group" "swe_zpes_developer_rw_group" {
  name = "${local.iam-prefix}${local.env}-swe-zpes-developer-rw-group"
}

resource "aws_iam_group_policy" "swe_zpes_developer_pass_role_policy" {
  name  = "${local.iam-prefix}${local.env}-swe-zpes-developer-pass-role-policy"
  group = aws_iam_group.swe_zpes_developer_rw_group.name

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : "iam:PassRole",
          "Resource" : var.swe_zpes_pass_role_list
        }
      ]
    }
  )
}


resource "aws_iam_group_policy_attachment" "swe_zpes_developer_resource_rw_policy_attach" {
  group      = aws_iam_group.swe_zpes_developer_rw_group.name
  policy_arn = aws_iam_policy.swe_zpes_developer_resource_rw_policy.arn

}
resource "aws_iam_group_policy_attachment" "swe_zpes_developer_compute_rw_policy_attach" {
  group      = aws_iam_group.swe_zpes_developer_rw_group.name
  policy_arn = aws_iam_policy.swe_zpes_developer_compute_rw_policy.arn
}

data "aws_iam_policy" "swe_zxc_developer_compute_rw_policy" {
  arn = "arn:aws:iam::039287201034:policy/aws-zxc-eu-data-${local.env}-s3-rw-policy"
}

resource "aws_iam_group_policy_attachment" "swe_zpes_developer_zxc_rw_policy_attach" {
  for_each = toset( [
    "arn:aws:iam::039287201034:policy/aws-zxc-eu-data-uat-s3-rw-policy",
    "arn:aws:iam::039287201034:policy/${local.env}-zxc-developer-compute-rw-policy",
    "arn:aws:iam::039287201034:policy/${local.env}-zxc-developer-resource-rw-policy",
    "arn:aws:iam::039287201034:policy/${local.env}-zxc-flink-service-resource-policy",
    "arn:aws:iam::039287201034:policy/${local.env}-zxc-lambda-service-resource-policy",
    "arn:aws:iam::039287201034:policy/${local.env}-zxc-lambda-service-resource-policy",
  ])
  group      = aws_iam_group.swe_zpes_developer_rw_group.name
  policy_arn = each.value
}

#resource "aws_iam_group_policy_attachment" "swe_zpes_developer_lambda_rw_policy_attach" {
#  group      = aws_iam_group.swe_zpes_developer_rw_group.name
#  policy_arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
#}
#resource "aws_iam_group_policy_attachment" "swe_zpes_developer_sqs_rw_policy_attach" {
#  group      = aws_iam_group.swe_zpes_developer_rw_group.name
#  policy_arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
#}
##endregion

