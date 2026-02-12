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
  description = "Name of the cluster"
  type        = string
}
variable "port" {
  type    = number
  default = 6379
}

variable "automatic_failover_enabled" {
  type    = bool
  default = true
}
variable "multi_az_enabled" {
  type    = bool
  default = true
}

variable "auto_minor_version_upgrade" {
  type    = bool
  default = false
}
variable "engine" {
  description = "The database engine to use"
  type        = string
  default     = "redis"
}
variable "engine_version" {
  description = "The engine version to use"
  type        = string
  default     = "6.2"
}

variable "node_type" {
  type = string
}
variable "num_cache_clusters" {
  type = number
}


variable "password" {
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file"
  type        = string
  default     = null
}
#endregion

variable "create_parameter_group" {
  type    = bool
  default = true
}
variable "parameter_group_name" {
  description = "Name of the DB parameter group to associate"
  type        = string
  default     = "default.redis6.x"
}
variable "parameter_group_family" {
  type = string
}

#region VPC

variable "vpc_id" {
  description = "VPC"
  type        = string

}
variable "private_subnet_ids" {
  description = "A list of subnets to connect to in client VPC ([documentation](https://docs.aws.amazon.com/msk/1.0/apireference/clusters.html#clusters-prop-brokernodegroupinfo-clientsubnets))"
  type        = list(string)
}

variable "subnet_group_name" {
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC"
  type        = string
  default     = null
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
#endregin

#region
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
#endregion


variable "timeouts" {
  description = "Updated Terraform resource management timeouts. Applies to `aws_db_instance` in particular to permit resource management times"
  type        = map(string)
  default     = {
    create : "60m"
    update : "60m"
    delete : "60m"
  }
}

