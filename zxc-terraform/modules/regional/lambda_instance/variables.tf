variable "base_config" {
  type = object({
    env                  = string
    aws_region           = string,
    aws_account_id       = string,
    local_yaml_file_name = string
  })
}

variable "tags" {
  description = "A map of tags to assign to the resources created"
  type        = map(string)
  default     = {}
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}
variable "sqs_arn" {
  type = string
}
variable "s3_arn" {
  type = string
}
variable "aws_zxc_lambda_s3_bucket" {
  type = string
}
variable "zxc_lambda_role_arn" {
  type = string
}

variable "aws_zxc_s3_data_sqs_arn" {
  type = string
}


###region flink config
variable "aws_zxc_s3_data_bucket_name" {
  type = string
}
variable "front_kafka_bootstrap_brokers" {
  type = string
}
variable "back_kafka_bootstrap_brokers" {
  type = string
}
variable "vdp_front_kafka_brokers" {
  type = string
}

#endregion