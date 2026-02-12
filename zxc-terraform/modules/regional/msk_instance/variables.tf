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

variable "bigdata_msk_logs_s3_bucket" {
  type = string
}
