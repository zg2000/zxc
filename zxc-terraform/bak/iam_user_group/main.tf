provider "aws" {
  region = var.base_config.aws_region
}

data "local_file" "config_file" {
  filename = "environments/${var.base_config.env}/${var.base_config.aws_region}/config.yaml"
}

locals {
  env = var.base_config.env
}

resource "aws_iam_group" "bigdata_support_basic_group" {
  name = "bigdata-support-basic-Group"
}
resource "aws_iam_group_policy_attachment" "bigdata_support_basic_group_attach" {
  for_each = [
    "arn:aws:iam::aws:policy/AWSSupportAccess",
    "arn:aws:iam::aws:policy/AWSSupportAppFullAccess",
    "arn:aws:iam::aws:policy/job-function/SupportUser"
  ]
  group      = aws_iam_group.bigdata_support_basic_group.name
  policy_arn = each.value
}

resource "aws_iam_group" "zxc_admin_group" {
  name = "zxc-admin-Group"
}
resource "aws_iam_group_policy_attachment" "zxc_admin_group_attach" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AWSCloud9Administrator",
  ])
  group      = aws_iam_group.zxc_admin_group.name
  policy_arn = each.value
}

resource "aws_iam_group" "zxc_storage_group" {
  name = "zxc-storage-Group"
}
resource "aws_iam_group_policy_attachment" "zxc_storage_group_attach" {
  for_each = toset([
    aws_iam_policy.zxc_s3_policy.arn,
  ])
  group      = aws_iam_group.zxc_storage_group.name
  policy_arn = each.value
}

#resource "aws_iam_policy" "policy" {
#  name        = "test-policy"
#  description = "A test policy"
#  policy      = "{ ... policy JSON ... }"
#}

