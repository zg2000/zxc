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
}

terraform {
  backend "s3" {
    encrypt = true
    region = "us-east-1"
    bucket = "zxc-terraform"
    key    = "uat/bigdata-zxc-terraform.tfstate"
  }
}