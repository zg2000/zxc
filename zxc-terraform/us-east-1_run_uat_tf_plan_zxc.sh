#!/bin/bash


TARGET_MODULE=${1}

if [ $TARGET_MODULE ];then
	echo "TARGET_MODULE = $TARGET_MODULE"
else
	echo "TARGET_MODULE IS NOT EXISTS"
fi

ENV="uat"
DIR_NAME="us-east-1"
REGION="us-east-1"

tf_backend_state_region="us-east-1"
tf_backend_state_bucket="zxc-terraform";
tf_backend_state_file="uat/zxc-terraform.tfstate";

#
echo "terraform init -reconfigure -backend-config="key=$tf_backend_state_file" -backend-config="region=$tf_backend_state_region" -backend-config="bucket=$tf_backend_state_bucket""
terraform init -reconfigure -backend-config="key=$tf_backend_state_file" -backend-config="region=$tf_backend_state_region" -backend-config="bucket=$tf_backend_state_bucket"

if [ $TARGET_MODULE ];then
	echo "-----------------TARGET_MODULE = $TARGET_MODULE-----------------"
	echo "terraform plan -var="dir_name=${DIR_NAME}"  -var-file "environments/${ENV}/${DIR_NAME}/variables.tfvars" -target ${TARGET_MODULE}"
  terraform plan -var="dir_name=${DIR_NAME}"  -var-file "environments/${ENV}/${DIR_NAME}/variables.tfvars" -target ${TARGET_MODULE}
else
	echo "-----------------TARGET_MODULE IS NOT EXISTS-------------------"
	echo "terraform plan -var="dir_name=${DIR_NAME}"  -var-file "environments/${ENV}/${DIR_NAME}/variables.tfvars""
  terraform plan -var="dir_name=${DIR_NAME}"  -var-file "environments/${ENV}/${DIR_NAME}/variables.tfvars"
fi
#
#terraform plan -var-file "environments/uat/${DIR_NAME}/variables.tfvars"
#terraform plan -var-file "environments/uat/${DIR_NAME}/variables.tfvars"  -target ${TARGET_MODULE}





