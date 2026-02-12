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

variable "zxc_front_msk_sg_id" {
  type = string
}
variable "zxc_back_msk_sg_id" {
  type = string
}

#variable "zxc_redshift_sg_id" {
#  type = string
#}

variable "zxc_flink_sg_id" {
  type = string
}

variable "zxc_lambda_sg_id" {
  type = string
}

variable "vdp_front_msk_sg_id" {
  type = string
}
