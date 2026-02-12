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

variable "vpc_id" {
  type = string
}
variable "private_subnet_ids" {
  type = list(string)
}

variable "private_subnet_availability_zones" {
  type = list(string)
}

variable "swe_zpes_glue_service_role_arn" {
  type = string
}
variable "swe_zpes_glue_s3_arn" {
  type = string
}
variable "swe_zpes_glue_s3_bucket" {
  type = string
}


