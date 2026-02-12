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
resource "aws_iam_group" "zxc_developer_basic_group" {
  name = "zxc-support-basic-Group"
}
resource "aws_iam_group_policy_attachment" "zxc_developer_basic_group_support_policy_attach" {
  for_each = toset( [
    "arn:aws:iam::aws:policy/AWSSupportAccess",
    "arn:aws:iam::aws:policy/AWSSupportAppFullAccess",
    "arn:aws:iam::aws:policy/job-function/SupportUser"
  ])
  group      = aws_iam_group.zxc_developer_basic_group.name
  policy_arn = each.value
}
##endregion

## region  zxc_developer_rw_group
resource "aws_iam_group" "zxc_developer_rw_group" {
  name = "${local.iam-prefix}${local.env}-zxc-developer-rw-group"
}

resource "aws_iam_group_policy" "zxc_developer_pass_role_policy" {
  name  = "${local.iam-prefix}${local.env}-zxc-developer-pass-role-policy"
  group = aws_iam_group.zxc_developer_rw_group.name

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : "iam:PassRole",
          "Resource" : var.zxc_pass_role_list
        }
      ]
    }
  )
}


resource "aws_iam_group_policy_attachment" "zxc_developer_resource_rw_policy_attach" {
  group      = aws_iam_group.zxc_developer_rw_group.name
  policy_arn = aws_iam_policy.zxc_developer_resource_rw_policy.arn

}
resource "aws_iam_group_policy_attachment" "zxc_developer_compute_rw_policy_attach" {
  group      = aws_iam_group.zxc_developer_rw_group.name
  policy_arn = aws_iam_policy.zxc_developer_compute_rw_policy.arn
}

resource "aws_iam_group_policy_attachment" "zxc_developer_lambda_rw_policy_attach" {
  group      = aws_iam_group.zxc_developer_rw_group.name
  policy_arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
}
resource "aws_iam_group_policy_attachment" "zxc_developer_sqs_rw_policy_attach" {
  group      = aws_iam_group.zxc_developer_rw_group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
}
##endregion

