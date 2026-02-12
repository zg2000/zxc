locals {
  Bigdata-Service-S3-Policy             = jsondecode(file("${path.module}/base/Bigdata-Service-S3-Policy.json"))
  Bigdata-Service-SecretsManager-Policy = jsondecode(file("${path.module}/base/Bigdata-Service-SecretsManager-Policy.json"))
  Bigdata-Service-MSK-Policy            = jsondecode(file("${path.module}/base/Bigdata-Service-MSK-Policy.json"))
  Bigdata-Service-RDS-Policy            = jsondecode(file("${path.module}/base/Bigdata-Service-RDS-Policy.json"))
  Bigdata-Service-Redis-Policy          = jsondecode(file("${path.module}/base/Bigdata-Service-Redis-Policy.json"))
}

resource "aws_iam_policy" "Bigdata-Service-S3-Policy" {
  name        = "${local.env}-Bigdata-Service-S3-Policy"
  path        = "/"
  description = "${local.env}-Bigdata-Service-S3-Policy"
  policy      = jsonencode(local.Bigdata-Service-S3-Policy)
}
resource "aws_iam_policy" "Bigdata-Service-SecretsManager-Policy" {
  name        = "${local.env}-Bigdata-Service-SecretsManager-Policy"
  path        = "/"
  description = "${local.env}-Bigdata-Service-SecretsManager-Policy"
  policy      = jsonencode(local.Bigdata-Service-SecretsManager-Policy)
}
resource "aws_iam_policy" "Bigdata-Service-MSK-Policy" {
  name        = "${local.env}-Bigdata-Service-MSK-Policy"
  path        = "/"
  description = "${local.env}-Bigdata-Service-MSK-Policy"
  policy      = jsonencode(local.Bigdata-Service-SecretsManager-Policy)
}

resource "aws_iam_policy" "Bigdata-Service-RDS-Policy" {
  name        = "${local.env}-Bigdata-Service-RDS-Policy"
  path        = "/"
  description = "${local.env}-Bigdata-Service-RDS-Policy"
  policy      = jsonencode(local.Bigdata-Service-RDS-Policy)
}
resource "aws_iam_policy" "Bigdata-Service-Redis-Policy" {
  name        = "${local.env}-Bigdata-Service-Redis-Policy"
  path        = "/"
  description = "${local.env}-Bigdata-Service-Redis-Policy"
  policy      = jsonencode(local.Bigdata-Service-Redis-Policy)
}