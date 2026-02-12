#locals {
#  #  s3_buckets = [var.bigdata_glue_s3_bucket, var.bigdata_data_s3_bucket]
#}
#
#
#resource "aws_iam_policy" "zxc_glue_resource_policy" {
#  name        = "${local.iam-prefix}${local.env}-zxc-glue-service-resource-policy"
#  path        = "/"
#  description = "${local.iam-prefix}${local.env}-zxc-glue-service-resource-policy"
#  policy      = jsonencode(
#    {
#      "Version" : "2012-10-17",
#      "Statement" : [
#        {
#          "Effect" : "Allow",
#          "Action" : [
#            "s3:GetObject",
#            "s3:PutObject",
#            "s3:DeleteObject"
#          ],
#          "Resource" : [
#            "arn:aws:s3:::${var.zxc_data_s3_bucket}/*",
#            "arn:aws:s3:::${var.zxc_glue_s3_bucket}/*"
#          ]
#        }, {
#          "Effect" : "Allow",
#          "Action" : [
#            "secretsmanager:Get*",
#            "secretsmanager:Describe*",
#            "secretsmanager:List*"
#          ],
#          "Resource" : [
#            "arn:aws:secretsmanager:*:*:secret:${local.env}/bigdata/vdp/*"
#          ]
#        },
#        {
#          "Effect" : "Allow",
#          "Action" : "iam:PassRole",
#          "Resource" : [
#            "*"
#          ]
#        },
#        {
#          "Effect" : "Allow",
#          "Action" : "redshift:*",
#          "Resource" : [
#            "${var.zxc_redshift_arn}"
#          ]
#        }
#      ]
#    }
#  )
#}
#
#
