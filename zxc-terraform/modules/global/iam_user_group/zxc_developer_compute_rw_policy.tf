locals {

}

resource "aws_iam_policy" "zxc_developer_compute_rw_policy" {
  name        = "${local.iam-prefix}${local.env}-zxc-developer-compute-rw-policy"
  path        = "/"
  description = "${local.iam-prefix}${local.env}-zxc-developer-compute-rw-policy"
  policy      = jsonencode(

    {
      "Version" : "2012-10-17",
      "Statement" : [
        ## region FLink
        {
          "Effect" : "Allow",
          "Action" : [
            "kinesisanalytics:DiscoverInputSchema",
            "kinesisanalytics:CreateApplication",
            "kinesisanalytics:ListApplications",
            "logs:*"
          ],
          "Resource" : "*"
        },
        {
          "Effect" : "Allow",
          "Action" : "kinesisanalytics:*",
          "Resource" : "arn:aws:kinesisanalytics:*:${local.aws_account_id}:application/${local.env}_aws_zxc_*"
        },
        {
          "Effect" : "Allow",
          "Action" : "kinesisanalytics:*",
          "Resource" : "arn:aws:kinesisanalytics:*:${local.aws_account_id}:application/${local.env}_vdp_*"
        },
        ## endregion
        ## region Glue
        {
          "Sid" : "VisualEditor0",
          "Effect" : "Allow",
          "Action" : [
            "glue:List*",
            "glue:Get*",
            "glue:Create*",
            "glue:Update*",
          ],
          "Resource" : "*"
        },
        {
          "Effect" : "Allow",
          "Action" : "glue:*",
          "Resource" : [
            "arn:aws:glue:*:${local.aws_account_id}:job/${local.env}_zxc_*",
            "arn:aws:glue:*:${local.aws_account_id}:job/${local.env}_vdp_*"
          ]
        },
        ## endregion

        ## region Lambda

        ## endregion
        ## region SQS
        ## endregion
      ]
    }

  )
}