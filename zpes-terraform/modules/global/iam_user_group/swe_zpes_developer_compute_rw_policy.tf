locals {

}

resource "aws_iam_policy" "swe_zpes_developer_compute_rw_policy" {
  name        = "${local.iam-prefix}${local.env}-swe-zpes-developer-compute-rw-policy"
  path        = "/"
  description = "${local.iam-prefix}${local.env}-swe-zpes-developer-compute-rw-policy"
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
          "Resource" : "arn:aws:kinesisanalytics:*:${local.aws_account_id}:application/${local.env}_swe_zpes_*"
        },
        {
          "Effect" : "Allow",
          "Action" : "kinesisanalytics:*",
          "Resource" : "arn:aws:kinesisanalytics:*:${local.aws_account_id}:application/${local.env}_zpes_*"
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
            "arn:aws:glue:*:${local.aws_account_id}:job/${local.env}_swe_zpes_*",
            "arn:aws:glue:*:${local.aws_account_id}:job/${local.env}_zpes_*",
            "arn:aws:glue:*:${local.aws_account_id}:catalog"
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