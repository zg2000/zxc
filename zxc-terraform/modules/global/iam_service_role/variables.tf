variable "base_config" {
  type = object({
    env                  = string
    aws_region           = string,
    aws_account_id       = string,
    local_yaml_file_name = string
  })
}
#
#variable "zxc_data_s3_arn" {
#  type    = string
#  default = null
#}
#variable "zxc_data_s3_bucket" {
#  type    = string
#  default = null
#}
variable "aws_zxc_flink_s3_arn" {
  type    = string
  default = null
}
variable "aws_zxc_flink_s3_bucket" {
  type    = string
  default = null
}
#variable "aws_zxc_data_s3_arn" {
#  type    = string
#  default = null
#}
#variable "aws_zxc_data_s3_bucket" {
#  type    = string
#  default = null
#}


variable "aws_zxc_lambda_s3_arn" {
  type    = string
  default = null
}
variable "aws_zxc_lambda_s3_bucket" {
  type    = string
  default = null
}
variable "aws_zxc_data_s3_bucket" {
  type    = string
  default = null
}
variable "aws_zxc_msk_logs_s3_bucket" {
  type    = string
  default = null
}
variable "aws_zxc_msk_logs_s3_arn" {
  type    = string
  default = null
}

#
#variable "zxc_redshift_arn" {
#  type    = string
#  default = null
#}


variable "tags" {
  description = "A map of tags to assign to the resources created"
  type        = map(string)
  default     = {}
}
