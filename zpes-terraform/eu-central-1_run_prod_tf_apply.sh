#!/bin/bash


TARGET_MODULE=${1}

if [ $TARGET_MODULE ];then
	echo "TARGET_MODULE = $TARGET_MODULE"
else
	echo "TARGET_MODULE IS NOT EXISTS"
fi

ENV="prod"
DIR_NAME="eu-central-1"
REGION="eu-central-1"

tf_backend_state_region="eu-central-1"
tf_backend_state_bucket="aws-eu-prod-terraform-s3";
tf_backend_state_file="${ENV}/swe-zpes-terraform.tfstate";

set -x
terraform init \
  -reconfigure \
  -backend-config="key=$tf_backend_state_file"  \
  -backend-config="region=$tf_backend_state_region"  \
  -backend-config="bucket=$tf_backend_state_bucket"

if [ $TARGET_MODULE ];then
	echo "-----------------TARGET_MODULE IS EXIST-------------------"
  terraform apply \
    -var="dir_name=${DIR_NAME}" \
    -var-file "environments/${ENV}/${DIR_NAME}/variables.tfvars" \
    -target ${TARGET_MODULE}
else
	echo "-----------------TARGET_MODULE IS NOT EXIST-------------------"
  terraform apply \
    -var="dir_name=${DIR_NAME}" \
    -var-file "environments/${ENV}/${DIR_NAME}/variables.tfvars"
fi
