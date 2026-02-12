locals {

}

#resource "aws_iam_policy" "swe_zpes_lambda_resource_policy" {
#
#  name        = "${local.iam-prefix}${local.env}-swe-zpes-lambda-service-resource-policy"
#  path        = "/"
#  description = "${local.iam-prefix}${local.env}-swe-zpes-lambda-service-resource-policy"
#  policy      = jsonencode(
#
#    {
#      "Version" : "2012-10-17",
#      "Statement" : [
#        #  s3=>script、data、日志
#        {
#          "Effect" : "Allow",
#          "Action" : [
#            "s3:GetBucketLocation",
#            "s3:ListBucket",
#            "s3:ListAllMyBuckets",
#            "s3:GetBucketAcl"
#          ],
#          "Resource" : [
#            "*",
#          ]
#        },
#        {
#          "Effect" : "Allow",
#          "Action" : [
#            "s3:GetObject",
#            "s3:PutObject",
#            "s3:DeleteObject"
#          ],
#          "Resource" : [
#            "arn:aws:s3:::${var.swe_zpes_data_s3_bucket}/*"
##            "arn:aws:s3:::${var.swe_zpes_lambda_s3_bucket}/*"
#          ]
#        },
#        #SQS
#        {
#          "Effect" : "Allow",
#          "Action" : "sqs:ListQueues",
#          "Resource" : "*"
#        },
#        {
#          "Effect" : "Allow",
#          "Action" : [
#            "sqs:ReceiveMessage",
#            "sqs:DeleteMessage",
#            "sqs:GetQueueAttributes"
#          ],
#          "Resource" : [
#            "arn:aws:sqs:*:${local.aws_account_id}:${local.env}_swe_zpes_*"
#          ]
#        },
#        #VPC
#        {
#          "Effect" : "Allow",
#          "Action" : [
#            "ec2:DescribeVpcEndpoints",
#            "ec2:DescribeRouteTables",
#            "ec2:CreateNetworkInterface",
#            "ec2:DeleteNetworkInterface",
#            "ec2:DescribeNetworkInterfaces",
#            "ec2:DescribeSecurityGroups",
#            "ec2:DescribeSubnets",
#            "ec2:DescribeVpcAttribute",
#            "iam:ListRolePolicies",
#            "iam:GetRole",
#            "iam:GetRolePolicy",
#          ],
#          "Resource" : [
#            "*"
#          ]
#        },
#        {
#          "Effect" : "Allow",
#          "Action" : [
#            "logs:CreateLogGroup",
#            "logs:CreateLogStream",
#            "logs:PutLogEvents",
#            "cloudwatch:PutMetricData"
#          ],
#          "Resource" : [
#            "*"
##            "arn:aws:logs:*:*:*:/aws-lambda/*"
#          ]
#        }
#      ]
#    }
#  )
#}