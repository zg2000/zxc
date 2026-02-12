provider "aws" {
  region = var.base_config.aws_region
}

data "local_file" "config_file" {
  filename = var.base_config.local_yaml_file_name
}

locals {
  env              = var.base_config.env
  yaml-config-data = yamldecode(data.local_file.config_file.content)

  resource-prefix      = local.yaml-config-data.basic.resource-prefix
  private_bucket_names = [
    "${local.resource-prefix}-flink-${local.env}-s3",
    "${local.resource-prefix}-msk-logs-${local.env}-s3",
    "${local.resource-prefix}-lambda-${local.env}-s3",
    #    "${local.resource-prefix}-data-${local.env}-s3",
  ]
}


##region private
resource "aws_s3_bucket" "private_bucket_list" {
  for_each = toset(local.private_bucket_names)
  bucket   = each.value
  tags     = var.tags
}
resource "aws_s3_bucket_ownership_controls" "private_bucket_ownership_controls" {
  depends_on = [aws_s3_bucket.private_bucket_list]
  for_each   = toset(local.private_bucket_names)
  bucket     = each.value
  rule {
    object_ownership = "ObjectWriter"
  }
}
resource "aws_s3_bucket_acl" "private_bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.private_bucket_ownership_controls]
  for_each   = toset(local.private_bucket_names)
  bucket     = each.value
  acl        = "private"
}
##endregion

data "aws_s3_bucket" "data-bucket" {
  bucket = "aws-zxc-eu-data-prod-s3"
}