#!/bin/bash

ENV="uat"

tf_backend_state_region="eu-central-1"
tf_backend_state_bucket="aws-zpes-eu-terraform-uat-s3";
tf_backend_state_file="uat/swe-zpes-terraform.tfstate";

# 初始化 Terraform 工作目录：配置后端的存储键（key）、存储区域（region）、存储桶（bucket）
terraform init \
  -reconfigure \
  -backend-config="key=$tf_backend_state_file"  \
  -backend-config="region=$tf_backend_state_region"  \
  -backend-config="bucket=$tf_backend_state_bucket"

# 生成一个执行计划，显示将要执行的操作和变更
terraform plan  \
  -var-file "environments/${ENV}/eu-central-1/variables.tfvars"  \
  -target "${TARGET_MODULE}"

# 应用执行计划中的变更并创建、修改或删除基础设施资源
terraform apply  \
  -var-file "environments/${ENV}/eu-central-1/variables.tfvars"  \
  -target "${TARGET_MODULE}"
