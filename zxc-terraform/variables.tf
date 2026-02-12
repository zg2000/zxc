variable "env" {
  type    = string
  default = "uat"
}
variable "aws_region" {
  type    = string
  default = "us-east-1"
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

variable "vdp_front_kafka_brokers" {
  type = string
}

variable "vdp_front_kafka_sg_id" {
  type = string
}
