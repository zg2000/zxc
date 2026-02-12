variable "create" {
  description = "Determines whether cluster resources will be created"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to assign to the resources created"
  type        = map(string)
  default     = {}
}

#region basic Config
variable "name" {
  type = string
}
variable "runtime_environment" {
  description = "The runtime environment for the application. Valid values: SQL-1_0, FLINK-1_6, FLINK-1_8, FLINK-1_11, FLINK-1_13, FLINK-1_15"
  type        = string
  default     = "FLINK-1_13"
}
variable "service_execution_role" {
  description = "The ARN of the IAM role used by the application to access Kinesis data streams, Kinesis Data Firehose delivery streams, Amazon S3 objects, and other external resources."
  type        = string
}

variable "code_config" {
  type = object({
    bucket_arn        = string
    file_key          = string,
    code_content_type = optional(string)
  })
}

variable "property_group_id" {
  description = "The key of the application execution property key-value map."
  type        = string
  default     = "group"
}

variable "property_map" {
  description = "Application execution property key-value map."
  type        = map(string)
  default     = {}
}

#region checkpoint
variable "checkpoint_config" {
  type = object({
    configuration_type            = string
    checkpointing_enabled         = optional(bool),
    checkpoint_interval           = optional(number)
    min_pause_between_checkpoints = optional(number)
  })
  default = {
    configuration_type            = "DEFAULT"
    checkpointing_enabled         = true
    checkpoint_interval           = 60000
    min_pause_between_checkpoints = 5000
  }
}
#endregion

#region  monitoring
variable "monitoring_config" {
  type = object({
    configuration_type = string
    #DEBUG, ERROR, INFO, WARN
    log_level          = optional(string),
    #APPLICATION, OPERATOR, PARALLELISM, TASK.
    metrics_level      = optional(string)
  })
  default = {
    configuration_type = "DEFAULT"
    log_level          = "INFO"
    metrics_level      = "TASK"
  }
}
#endregion

#region  parallelism
variable "parallelism_config" {
  type = object({
    configuration_type   = string
    auto_scaling_enabled = bool
    parallelism          = number
    parallelism_per_kpu  = number
  })
}
#endregion


#region vpc
variable "vpc_id" {
  type = string
}
variable "private_subnet_ids" {
  description = "A list of subnets to connect to in client VPC"
  type        = list(string)
}

variable "create_security_group" {
  type    = bool
  default = true
}
variable "vpc_security_group_ids" {
  description = "A list of the security groups to associate with the elastic network interfaces to control who can communicate with the cluster"
  type        = list(string)
  default     = []
}
#endregion

#region cloudwatch_log
variable "create_cloudwatch_log_group" {
  description = "Determines whether to create a CloudWatch log group"
  type        = bool
  default     = false
}

variable "cloudwatch_log_group_name" {
  description = "Name of the Cloudwatch Log Group to deliver logs to"
  type        = string
  default     = null
}

variable "cloudwatch_log_group_retention_in_days" {
  description = "Specifies the number of days you want to retain log events in the log group"
  type        = number
  default     = 0
}
#endregio

