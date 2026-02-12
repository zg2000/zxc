variable "base_config" {
  type = object({
    env            = string
    aws_region     = string,
    aws_account_id = string
  })
}
