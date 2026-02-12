variable "base_config" {
  type = object({
    env                  = string
    aws_region           = string,
    aws_account_id       = string,
    local_yaml_file_name = string
  })
}

variable "vpc_id" {
  type = string
}

variable "tags" {
  description = "A map of tags to assign to the resources created"
  type        = map(string)
  default     = {}
}

variable "swe_zpes_front_msk_sg_id" {
  type = string
}

#variable "swe_zpes_redshift_sg_id" {
#  type = string
#}

variable "swe_zpes_rds_sg_id" {
  type = string
}

variable "swe_zpes_flink_sg_id" {
  type = string
}

variable "swe_zpes_glue_sg_id" {
  type = string
}

