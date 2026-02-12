variable "base_config" {
  type = object({
    env                  = string
    aws_region           = string,
    aws_account_id       = string,
    local_yaml_file_name = string
  })
}

variable "swe_zpes_kafka_arn_list" {
  type    = list(string)
  default = []
}

variable "swe_zpes_redshift_cluster_arn_list" {
  type = list(string)
}

variable "swe_zpes_rds_arn_list" {
  type = list(string)
}

variable "swe_zpes_redis_arn_list" {
  type = list(string)
}

variable "swe_zpes_pass_role_list" {
  type = list(string)
}