provider "aws" {
  region = var.base_config.aws_region
}

data "local_file" "config_file" {
  filename = var.base_config.local_yaml_file_name
}

locals {
  env              = var.base_config.env
  yaml-config-data = yamldecode(data.local_file.config_file.content)

  resource-prefix = local.yaml-config-data.basic.resource-prefix

  private_bucket_names = [
    "${local.resource-prefix}-flink-${local.env}-s3",
    "${local.resource-prefix}-glue-${local.env}-s3",
    "${local.resource-prefix}-msk-logs-${local.env}-s3",
    "${local.resource-prefix}-app-be-${local.env}-s3"
  ]
  public_read_bucket_names = [
    "${local.resource-prefix}-app-fe-${local.env}-s3"
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


##region public read
resource "aws_s3_bucket" "public_read_bucket_names" {
  for_each = toset(local.public_read_bucket_names)
  bucket   = each.value
  tags     = var.tags
}

resource "aws_s3_bucket_public_access_block" "public_read_bucket_access_block" {
  depends_on = [aws_s3_bucket.public_read_bucket_names]

  for_each = toset(local.public_read_bucket_names)
  bucket   = each.value

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "public_read_bucket_ownership_controls" {
  depends_on = [aws_s3_bucket_public_access_block.public_read_bucket_access_block]
  for_each   = toset(local.public_read_bucket_names)
  bucket     = each.value
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_acl" "public_read_bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.public_read_bucket_ownership_controls]
  for_each   = toset(local.public_read_bucket_names)
  bucket     = each.value
  acl        = "public-read"
}


resource "aws_s3_bucket_policy" "public_read_bucket_0_policy" {
  depends_on = [aws_s3_bucket_acl.public_read_bucket_acl]
  bucket     = local.public_read_bucket_names[0]

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowPublicRead",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : [
          "s3:Get*",
          "s3:Put*",
        ],
        "Resource" : "arn:aws:s3:::${local.public_read_bucket_names[0]}/*"
      }
    ]
  })
}
##endregion


