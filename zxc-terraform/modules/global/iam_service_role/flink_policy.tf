locals {

}


resource "aws_iam_policy" "zxc_flink_resource_policy" {
  name        = "${local.iam-prefix}${local.env}-zxc-flink-service-resource-policy"
  path        = "/"
  description = "${local.iam-prefix}${local.env}-zxc-flink-service-resource-policy"
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
            "arn:aws:s3:::${var.aws_zxc_flink_s3_bucket}/*",
            "arn:aws:s3:::${var.aws_zxc_flink_s3_bucket}",
          ]
        }, {
          "Effect" : "Allow",
          "Action" : [
            "secretsmanager:GetRandomPassword",
            "secretsmanager:GetResourcePolicy",
            "secretsmanager:GetSecretValue",
            "secretsmanager:DescribeSecret",
            "secretsmanager:ListSecretVersionIds",
            "secretsmanager:ListSecrets"
          ],
          "Resource" : [
            "arn:aws:secretsmanager:*:*:secret:${local.env}/zxc/*"
          ]
        }, {
          "Effect" : "Allow",
          "Action" : [
            "glue:Get*",
            "glue:List*",
            "glue:Describe*",
            "glue:View*",
            "glue:CreateDatabase",
          ],
          "Resource" : "*"
        }
      ]
    }
  )
}


