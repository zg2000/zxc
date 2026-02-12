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

variable "swe_zpes_data_s3_arn" {
  type = string
}