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
variable "cluster_identifier" {
  description = "Name of the cluster"
  type        = string
}
variable "database_name" {
  description = "database_name"
  type        = string
}
variable "port" {
  type    = number
  default = 5439
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
##region
variable "snapshot_identifier" {
  description = "The name of the snapshot from which to create the new cluster"
  type        = string
  default     = null
}
variable "snapshot_cluster_identifier" {
  description = "The name of the cluster the source snapshot was created from"
  type        = string
  default     = null
}
variable "skip_final_snapshot" {
  description = "Determines whether a final snapshot of the cluster is created before Redshift deletes the cluster. If true, a final cluster snapshot is not created. If false , a final cluster snapshot is created before the cluster is deleted"
  type        = bool
  default     = true
}
variable "final_snapshot_identifier" {
  description = "The identifier of the final snapshot that is to be created immediately before deleting the cluster. If this parameter is provided, `skip_final_snapshot` must be `false`"
  type        = string
  default     = null
}
#endregion

variable "node_type" {
  type = string
}
variable "number_of_nodes" {
  type = number
}

#endregion
variable "create_parameter_group" {
  description = "Determines whether to create a parameter group or use existing"
  type        = bool
  default     = true
}
variable "parameter_group_name" {
  description = "The name of the Redshift parameter group, existing or to be created"
  type        = string
  default     = null
}
variable "parameter_group_family" {
  description = "The family of the Redshift parameter group"
  type        = string
  default     = "redshift-1.0"
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

variable "encrypted" {
  description = "If `true`, the data in the cluster is encrypted at rest"
  type        = bool
  default     = true
}
variable "kms_key_arn" {
  description = "The ARN for the KMS encryption key. When specifying `kms_key_arn`, `encrypted` needs to be set to `true`"
  type        = string
  default     = null
}
#endregin


#region optional
variable "allow_version_upgrade" {
  description = "If `true`, major version upgrades can be applied during the maintenance window to the Amazon Redshift engine that is running on the cluster. Default is `true`"
  type        = bool
  default     = null
}

variable "apply_immediately" {
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window. Default is `false`"
  type        = bool
  default     = null
}
variable "aqua_configuration_status" {
  description = "The value represents how the cluster is configured to use AQUA (Advanced Query Accelerator) after the cluster is restored. Possible values are `enabled`, `disabled`, and `auto`. Requires Cluster reboot"
  type        = string
  default     = null
}
variable "automated_snapshot_retention_period" {
  description = "The number of days that automated snapshots are retained. If the value is 0, automated snapshots are disabled. Even if automated snapshots are disabled, you can still create manual snapshots when you want with create-cluster-snapshot. Default is 1"
  type        = number
  default     = null
}
variable "availability_zone" {
  description = "The EC2 Availability Zone (AZ) in which you want Amazon Redshift to provision the cluster. Can only be changed if `availability_zone_relocation_enabled` is `true`"
  type        = string
  default     = null
}
variable "availability_zone_relocation_enabled" {
  description = "If `true`, the cluster can be relocated to another availability zone, either automatically by AWS or when requested. Default is `false`. Available for use on clusters from the RA3 instance family"
  type        = bool
  default     = null
}

variable "cluster_version" {
  description = "The version of the Amazon Redshift engine software that you want to deploy on the cluster. The version selected runs on all the nodes in the cluster"
  type        = string
  default     = null
}
variable "enhanced_vpc_routing" {
  description = "If `true`, enhanced VPC routing is enabled"
  type        = bool
  default     = null
}
variable "publicly_accessible" {
  description = "If true, the cluster can be accessed from a public network"
  type        = bool
  default     = false
}

variable "logging" {
  description = "Logging configuration for the cluster"
  type        = any
  default     = {}
}
#endregion



################################################################################
# IAM Roles
################################################################################

variable "iam_role_arns" {
  description = "A list of IAM Role ARNs to associate with the cluster. A Maximum of 10 can be associated to the cluster at any time"
  type        = list(string)
  default     = []
}

variable "default_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) for the IAM role that was set as default for the cluster when the cluster was created"
  type        = string
  default     = null
}
