locals {
  Bigdata-Service-Glue-Redshift-Policy = jsondecode(file("${path.module}/glue/Bigdata-Service-Glue-Redshift-Policy.json"))
  Bigdata-Service-Glue-Admin-Policy    = jsondecode(file("${path.module}/glue/Bigdata-Service-Glue-Admin-Policy.json"))
  Bigdata-Service-Glue-IAM-Policy      = jsondecode(file("${path.module}/glue/Bigdata-Service-Glue-IAM-Policy.json"))
  Bigdata-Service-Glue-PassRole-Policy = jsondecode(file("${path.module}/glue/Bigdata-Service-Glue-PassRole-Policy.json"))
}

resource "aws_iam_policy" "Bigdata-Service-Glue-Redshift-Policy" {
  name        = "${local.env}-Bigdata-Service-Glue-Redshift-Policy"
  path        = "/"
  description = "${local.env}-Bigdata-Service-Glue-Redshift-Policy"
  policy      = jsonencode(local.Bigdata-Service-Glue-Redshift-Policy)
}

resource "aws_iam_policy" "Bigdata-Service-Glue-Admin-Policy" {
  name        = "${local.env}-Bigdata-Service-Glue-Admin-Policy"
  path        = "/"
  description = "${local.env}-Bigdata-Service-Glue-Admin-Policy"
  policy      = jsonencode(local.Bigdata-Service-Glue-Admin-Policy)
}

resource "aws_iam_policy" "Bigdata-Service-Glue-IAM-Policy" {
  name        = "${local.env}-Bigdata-Service-Glue-IAM-Policy"
  path        = "/"
  description = "${local.env}-Bigdata-Service-Glue-IAM-Policy"
  policy      = jsonencode(local.Bigdata-Service-Glue-IAM-Policy)
}

resource "aws_iam_policy" "Bigdata-Service-Glue-PassRole-Policy" {
  name        = "${local.env}-Bigdata-Service-Glue-PassRole-Policy"
  path        = "/"
  description = "${local.env}-Bigdata-Service-Glue-PassRole-Policy"
  policy      = jsonencode(local.Bigdata-Service-Glue-PassRole-Policy)
}



