variable "base_config" {
  type = object({
    env                  = string
    aws_region           = string,
    aws_account_id       = string,
    local_yaml_file_name = string
  })
}

variable "zxc_kafka_arn_list" {
  type    = list(string)
  default = []
}

#variable "zxc_redshift_cluster_arn_list" {
#  type = list(string)
#}

variable "zxc_rds_arn_list" {
  type = list(string)
}

variable "zxc_redis_arn_list" {
  type = list(string)
}

variable "zxc_pass_role_list" {
  type = list(string)
}