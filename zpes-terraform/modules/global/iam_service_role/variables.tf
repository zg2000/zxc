variable "base_config" {
  type = object({
    env                  = string
    aws_region           = string,
    aws_account_id       = string,
    local_yaml_file_name = string
  })
}

variable "swe_zpes_data_s3_arn" {
  type    = string
  default = null
}
variable "swe_zpes_data_s3_bucket" {
  type    = string
  default = null
}
variable "swe_zpes_flink_s3_arn" {
  type    = string
  default = null
}
variable "swe_zpes_flink_s3_bucket" {
  type    = string
  default = null
}
variable "swe_zpes_glue_s3_arn" {
  type    = string
  default = null
}
variable "swe_zpes_glue_s3_bucket" {
  type    = string
  default = null
}


variable "swe_zpes_lambda_s3_arn" {
  type    = string
  default = null
}
variable "swe_zpes_lambda_s3_bucket" {
  type    = string
  default = null
}


variable "swe_zpes_redshift_arn" {
  type    = string
  default = null
}

variable "swe_zpes_kafka_arn_list" {
  type    = list(string)
  default = []
}
variable "swe_zpes_rds_arn_list" {
  type    = list(string)
  default = []
}

variable "tags" {
  description = "A map of tags to assign to the resources created"
  type        = map(string)
  default     = {}
}
