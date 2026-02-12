locals {

}

resource "aws_iam_policy" "swe_zpes_flink_basic_policy" {

  name        = "${local.iam-prefix}${local.env}-swe-zpes-flink-service-basic-policy"
  path        = "/"
  description = "${local.iam-prefix}${local.env}-swe-zpes-flink-service-basic-policy"
  policy      = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "ec2:CreateNetworkInterface",
            "ec2:CreateNetworkInterfacePermission",
            "ec2:DescribeNetworkInterfaces",
            "ec2:DeleteNetworkInterface",
            "ec2:Describe*",
            "iam:ListRolePolicies",
            "iam:GetRole",
            "iam:GetRolePolicy",
            "cloudwatch:PutMetricData",
            "cloudwatch:GetMetricStatistics",
            "cloudwatch:ListMetrics"
          ],
          "Resource" : [
            "*"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:DescribeLogGroups",
            "logs:DescribeLogStreams"
          ],
          "Resource" : ["*"]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:DescribeLogGroups",
            "logs:DescribeLogStreams",
            "logs:CreateLogGroup",
            "logs:PutLogEvents",
            "logs:GetLogGroupFields",
            "logs:GetLogEvents"
          ],
          "Resource" : [
            "arn:aws:logs:*:*:*:/aws-flink/*",
            "arn:aws:logs:*:*:*:/aws/swe-zpes-flink-log-group/*"
          ]
        }
      ]
    }
  )
}

resource "aws_iam_policy" "swe_zpes_flink_resource_policy" {
  name        = "${local.iam-prefix}${local.env}-swe-zpes-flink-service-resource-policy"
  path        = "/"
  description = "${local.iam-prefix}${local.env}-swe-zpes-flink-service-resource-policy"
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
            "arn:aws:s3:::${var.swe_zpes_flink_s3_bucket}/*"
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
            "arn:aws:secretsmanager:*:*:secret:${local.env}/swe/zpes/*"
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

