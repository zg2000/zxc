provider "aws" {
  region = var.base_config.aws_region
}

locals {
  env = var.base_config.env

  aws_region     = var.base_config.aws_region
  aws_account_id = var.base_config.aws_account_id

  Bigdata-Service-CloudwatchForFluntd-Policy = jsondecode(file("${path.module}/eks/Bigdata-Service-CloudwatchForFluntd-Policy.json"))
}

resource "aws_iam_role" "Bigdata-Glue-Service-Role" {
  name                = "${local.env}-Bigdata-Glue-Service-Role"
  managed_policy_arns = [
    aws_iam_policy.Bigdata-Service-S3-Policy.arn,
    aws_iam_policy.Bigdata-Service-MSK-Policy.arn,
    aws_iam_policy.Bigdata-Service-SecretsManager-Policy.arn,
    aws_iam_policy.Bigdata-Service-Glue-Redshift-Policy.arn,
    aws_iam_policy.Bigdata-Service-Glue-Admin-Policy.arn,
    aws_iam_policy.Bigdata-Service-Glue-IAM-Policy.arn,
    aws_iam_policy.Bigdata-Service-Glue-PassRole-Policy.arn,
    "arn:aws-cn:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws-cn:iam::aws:policy/CloudWatchFullAccess",
    "arn:aws-cn:iam::aws:policy/CloudWatchLogsFullAccess"
  ]
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : [
            "redshift.amazonaws.com",
            "glue.amazonaws.com",
            "ec2.amazonaws.com"
          ]
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_role" "Bigdata-KDA-Service-Role" {
  name                = "${local.env}-Bigdata-KDA-Service-Role"
  managed_policy_arns = [
    aws_iam_policy.Bigdata-Service-S3-Policy.arn,
    aws_iam_policy.Bigdata-Service-MSK-Policy.arn,
    aws_iam_policy.Bigdata-Service-SecretsManager-Policy.arn,
    aws_iam_policy.Bigdata-Service-Kda-GetGlueDatabase-Policy.arn,
    "arn:aws-cn:iam::aws:policy/AmazonMSKFullAccess",
    "arn:aws-cn:iam::aws:policy/AmazonRDSFullAccess",
    "arn:aws-cn:iam::aws:policy/AmazonVPCFullAccess",
    "arn:aws-cn:iam::aws:policy/AmazonVPCReadOnlyAccess",
    "arn:aws-cn:iam::aws:policy/CloudWatchFullAccess"
  ]
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "kinesisanalytics.amazonaws.com"
        },
        "Action" : "sts:AssumeRole",
        "Condition" : {
          "StringEquals" : {
            "aws:SourceAccount" : "${local.aws_account_id}"
          },
          "ArnEquals" : {
            "aws:SourceArn" : [
              "arn:aws-cn:kinesisanalytics:${local.aws_region}:${local.aws_account_id}:application/${local.env}_vdp_*"
            ]
          }
        }
      }
    ]
  })
}


resource "aws_iam_role" "Bigdata-HermesK8s-Service-Role" {
  name                = "${local.env}-Bigdata-Hermes-K8s-Role"
  managed_policy_arns = [
    "arn:aws-cn:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws-cn:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws-cn:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws-cn:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws-cn:iam::aws:policy/AmazonEKSServicePolicy",
    "arn:aws-cn:iam::aws:policy/AmazonEKSVPCResourceController",
    "arn:aws-cn:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws-cn:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws-cn:iam::aws:policy/CloudWatchFullAccess",
    "arn:aws-cn:iam::aws:policy/IAMFullAccess"
  ]
  inline_policy {
    name   = "${local.env}-Bigdata-Service-S3-Inline-Policy"
    policy = jsonencode(local.Bigdata-Service-S3-Policy)
  }
  inline_policy {
    name   = "${local.env}-Bigdata-Service-MSK-Inline-Policy"
    policy = jsonencode(local.Bigdata-Service-MSK-Policy)
  }
  inline_policy {
    name   = "${local.env}-Bigdata-Service-RDS-Inline-Policy"
    policy = jsonencode(local.Bigdata-Service-RDS-Policy)
  }
  inline_policy {
    name   = "${local.env}-Bigdata-Service-Redis-Inline-Policy"
    policy = jsonencode(local.Bigdata-Service-Redis-Policy)
  }
  inline_policy {
    name   = "${local.env}-Bigdata-Service-CloudwatchForFluntd-Inline-Policy"
    policy = jsonencode(local.Bigdata-Service-CloudwatchForFluntd-Policy)
  }


  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : [
            "codebuild.amazonaws.com",
            "eks.amazonaws.com",
            "ec2.amazonaws.com"
          ]
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}