variable "env" {
  type    = string
  default = "uat"
}
variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "dir_name" {
  type = string
}

variable "aws_account_id" {
  type = string
}

variable "zeekr_root_user" {
  type = string
}