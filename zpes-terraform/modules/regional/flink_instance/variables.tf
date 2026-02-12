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

variable "zpes_flink_s3_arn" {
  type = string
}

variable "swe_zpes_flink_service_role_arn" {
  type = string
}

variable "rds_security_group_id" {
  type = string
}

###region flink config
variable "vehicleJdbcUrl" {
  type = string
}
variable "zpesJdbcUrl" {
  type = string
}
variable "ossBucketName" {
  type = string
}
variable "zpesKafkaBootstrapServers" {
  type = string
}
variable "kafkaTopicOfLogMetadata" {
  type = string
}
variable "kafkaTopicOfFileMetadata" {
  default = ""
}
#endregion