data "template_file" "zxc_s3_policy" {
  template = jsondecode(file("${path.module}/storage/zxc-s3-policy.json"))
  vars     = {
    env        = var.base_config.env
    aws_region = var.base_config.aws_region
  }
}


resource "aws_iam_policy" "zxc_s3_policy" {
  name        = "${local.env}-zxc-s3-policy"
  path        = "/"
  description = "${local.env}-zxc-s3-policy"
  policy      = jsonencode(data.template_file.zxc_s3_policy.rendered)
}