variable "create" {
  description = "Whether to create this resource or not?"
  type        = bool
  default     = true
}
variable "identifier" {
  description = "The name of the RDS instance"
  type        = string
}
variable "engine" {
  description = "The database engine to use"
  type        = string
}
variable "engine_version" {
  description = "The engine version to use"
  type        = string
}
variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = null
}
variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default     = null
}
variable "db_name" {
  description = "The DB name to create. If omitted, no database is created initially"
  type        = string
  default     = null
}
variable "username" {
  description = "Username for the master DB user"
  type        = string
  default     = null
}
variable "password" {
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file"
  type        = string
  default     = null
}

#vpc
variable "vpc_id" {
  description = "VPC"
  type        = string
}
variable "private_subnet_ids" {
  type = list(string)
}


variable "create_parameter_group" {
  type    = bool
  default = true
}
variable "parameter_group_name" {
  description = "Name of the DB parameter group to associate"
  type        = string
  default     = null
}
variable "parameter_group_family" {
  type = string
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC"
  type        = string
  default     = null
}


variable "create_security_group" {
  type    = bool
  default = true
}
variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type        = list(string)
  default     = []
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  type = number
}
variable "enabled_cloudwatch_logs_exports" {
  type    = list(string)
  default = ["audit", "error", "general", "slowquery"]
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "timeouts" {
  description = "Updated Terraform resource management timeouts. Applies to `aws_db_instance` in particular to permit resource management times"
  type        = map(string)
  default     = {
    create : "60m"
    update : "60m"
    delete : "60m"
  }
}

