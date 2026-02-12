locals {
  Bigdata-Service-Kda-GetGlueDatabase-Policy = jsondecode(file("${path.module}/kda/Bigdata-Service-Kda-GetGlueDatabase-Policy.json"))
}

resource "aws_iam_policy" "Bigdata-Service-Kda-GetGlueDatabase-Policy" {
  name        = "${local.env}-Bigdata-Service-Kda-GetGlueDatabase-Policy"
  path        = "/"
  description = "${local.env}-Bigdata-Service-Kda-GetGlueDatabase-Policy"
  policy      = jsonencode(local.Bigdata-Service-Kda-GetGlueDatabase-Policy)
}
