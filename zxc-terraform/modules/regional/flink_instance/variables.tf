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

#variable "bigdata_flink_s3_arn" {
#  type = string
#}

variable "aws_zxc_flink_service_role_arn" {
  type = string
}
variable "aws_zxc_flink_s3_arn" {
  type = string
}

###region flink config
variable "rds_address" {
  type = string
}
variable "front_kafka_bootstrap_brokers" {
  type = string
}
variable "back_kafka_bootstrap_brokers" {
  type = string
}

#endregion

variable "vdp_front_kafka_brokers" {
  type = string
}