terraform {
  required_version = ">= 1.2.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.31.0"
    }
    template = {
      source  = "hashicorp/template"
      version = ">=2.2.0"
    }
  }

  backend "s3" {
    encrypt = true
    region = "eu-central-1"
    bucket = "aws-zpes-eu-tfstate-uat-s3"
    key    = "uat/swe-zpes-terraform.tfstate"
#    dynamodb_table = "aws-zpes-eu-terraform-uat-backend"
  }
}