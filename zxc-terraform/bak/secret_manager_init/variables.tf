variable "base_config" {
  type = object({
    aws_region         = string,
    aws_account_id     = string,
    env                = string,
    aws_backend_bucket = string,
    aws_backend_key    = string,
    dynamic_config     = object({
      vpc_id                    = string,
      private_subnet_ids        = list(string),
      public_subnet_ids         = list(string)
      private_security_group_id = string,
      public_security_group_id  = string,
      db_user                   = string,
      db_password               = string,
      zeekr_work_ip_list        = optional( list(string))
    })
  })
}