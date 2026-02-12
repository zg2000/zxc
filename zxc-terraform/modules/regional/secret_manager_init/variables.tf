variable "base_config" {
  type = object({
    env                  = string
    aws_region           = string,
    aws_account_id       = string,
    local_yaml_file_name = string
  })
}

#region rds config
variable "rds_endpoint" {
  type = string
}
variable "rds_address" {
  type = string
}
variable "rds_port" {
  type = string
}
#endregion

#region redis config
variable "redis_endpoint" {
  type = string
}
variable "redis_pwd" {
  type      = string
  sensitive = true
}
#endregion

#region redshift config
variable "redshift_cluster_identifier" {
  type = string
}
variable "redshift_cluster_endpoint" {
  type = string
}
variable "redshift_cluster_port" {
  type = string
}
#endregion


variable "front_kafka_bootstrap_brokers" {
  type = string
}
variable "back_kafka_bootstrap_brokers" {
  type = string
}

variable "tags" {
  description = "A map of tags to assign to the resources created"
  type        = map(string)
  default     = {}
}

