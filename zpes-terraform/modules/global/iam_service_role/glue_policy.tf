locals {

}


resource "aws_iam_policy" "swe_zpes_glue_resource_policy" {
  name        = "${local.iam-prefix}${local.env}-swe-zpes-glue-service-resource-policy"
  path        = "/"
  description = "${local.iam-prefix}${local.env}-swe-zpes-glue-service-resource-policy"
  policy      = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:GetObject",
            "s3:PutObject",
            "s3:DeleteObject"
          ],
          "Resource" : [
#            "arn:aws:s3:::${var.swe_zpes_data_s3_bucket}/*",
            "arn:aws:s3:::${var.swe_zpes_glue_s3_bucket}/*"
          ]
        }, {
          "Effect" : "Allow",
          "Action" : [
            "secretsmanager:Get*",
            "secretsmanager:Describe*",
            "secretsmanager:List*"
          ],
          "Resource" : [
            "arn:aws:secretsmanager:*:*:secret:${local.env}/swe/zpes/*"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : "redshift:*",
          "Resource" : [
#            "${var.swe_zpes_redshift_arn}"
            "arn:aws:redshift:eu-central-1:039287201034:cluster:aws-vdp-eu-data-${local.env}-redshift"
          ]
        }
      ]
    }
  )
}


