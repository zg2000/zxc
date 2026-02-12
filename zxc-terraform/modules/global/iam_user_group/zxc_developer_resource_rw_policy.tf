locals {

}


resource "aws_iam_policy" "zxc_developer_resource_rw_policy" {
  name        = "${local.iam-prefix}${local.env}-zxc-developer-resource-rw-policy"
  path        = "/"
  description = "${local.iam-prefix}${local.env}-zxc-developer-resource-rw-policy"

  policy = jsonencode(

    {
      "Version" : "2012-10-17",
      "Statement" : [

        ##region Kafka
        {
          "Effect" : "Allow",
          "Action" : [
            "kafka:*"
          ],
          "Resource" : var.zxc_kafka_arn_list
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "kafka:List*",
            "kafka:Get*",
            "kafka:Describe*",
            "kafka:View*"
          ],
          "Resource" : "*"
        },
        ## endregion
        ##region S3
        {
          "Effect" : "Allow",
          "Action" : "s3:*",
          "Resource" : [
            "arn:aws:s3:::${local.resource-prefix}*${local.env}*",
            "arn:aws:s3:::${local.resource-prefix}*${local.env}*/*"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:List*"
          ],
          "Resource" : "*"
        },
        ## endregion
        ##region redshift
#        {
#          "Effect" : "Allow",
#          "Action" : [
#            "redshift:*",
#            "redshift-serverless:*",
#            "redshift-data:*"
#          ],
#          "Resource" : var.zxc_redshift_cluster_arn_list
#        },
        ## endregion
        ##region RDS
        {
          "Effect" : "Allow",
          "Action" : [
            "rds:List*",
            "rds:Get*",
            "rds:Describe*",
            "rds:View*"
          ],
          "Resource" : var.zxc_rds_arn_list
        },
        ## endregion
        ##region Redis
        {
          "Effect" : "Allow",
          "Action" : [
            "elasticache:List*",
            "elasticache:Get*",
            "elasticache:Describe*",
            "elasticache:View*"
          ],
          "Resource" : var.zxc_redis_arn_list
        },
        ## endregion

        ##region secretsmanager
        {
          "Sid" : "VisualEditor0",
          "Effect" : "Allow",
          "Action" : [
            "secretsmanager:List*",
            "secretsmanager:Get*",
            "secretsmanager:Describe*",
            "secretsmanager:View*",
            "secretsmanager:PutSecretValue",
            "secretsmanager:CreateSecret",
            "secretsmanager:UpdateSecret",
            "secretsmanager:RestoreSecret",
            "secretsmanager:RotateSecret",
            "secretsmanager:UpdateSecretVersionStage"
          ],
          "Resource" : "*"
        },
        {
          "Effect" : "Allow",
          "Action" : "secretsmanager:*",
          "Resource" : [
            "arn:aws:secretsmanager:*:*:secret:${local.env}/bigdata-dw/*",
            "arn:aws:secretsmanager:*:*:secret:${local.env}/bigdata/vdp*"
          ]
        }
        ##endregion
      ]
    }

  )
}