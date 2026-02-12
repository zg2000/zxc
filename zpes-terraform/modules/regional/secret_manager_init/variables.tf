variable "base_config" {
  type = object({
    env                  = string
    aws_region           = string,
    aws_account_id       = string,
    local_yaml_file_name = string
  })
}

#region rds config
variable "secret_string" {
  type = string
}

variable "tags" {
  description = "A map of tags to assign to the resources created"
  type        = map(string)
  default     = {}
}

