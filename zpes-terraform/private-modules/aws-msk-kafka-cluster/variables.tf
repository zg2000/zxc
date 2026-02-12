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
  description = "Name of the MSK cluster"
  type        = string
  default     = "msk" # to avoid: Error: cluster_name must be 1 characters or higher
}

variable "kafka_version" {
  description = "Specify the desired Kafka software version"
  type        = string
  default     = "2.8.1"
}

variable "number_of_broker_nodes" {
  description = "The desired total number of broker nodes in the kafka cluster. It must be a multiple of the number of specified client subnets"
  type        = number
  default     = 3
}

variable "enhanced_monitoring" {
  description = "Specify the desired enhanced MSK CloudWatch monitoring level. See [Monitoring Amazon MSK with Amazon CloudWatch](https://docs.aws.amazon.com/msk/latest/developerguide/monitoring.html)"
  type        = string
  default     = "PER_TOPIC_PER_PARTITION"
}

variable "storage_mode" {
  description = "Controls storage mode for supported storage tiers. Valid values are: `LOCAL` or `TIERED`"
  type        = string
  default     = "LOCAL"
}

variable "broker_node_client_vpc_id" {
  description = "VPC"
  type        = string

}
variable "broker_node_client_subnets" {
  description = "A list of subnets to connect to in client VPC ([documentation](https://docs.aws.amazon.com/msk/1.0/apireference/clusters.html#clusters-prop-brokernodegroupinfo-clientsubnets))"
  type        = list(string)
}

variable "broker_node_security_groups" {
  description = "A list of the security groups to associate with the elastic network interfaces to control who can communicate with the cluster"
  type        = list(string)
  default     = []
}

variable "broker_node_instance_type" {
  description = "Specify the instance type to use for the kafka brokers. e.g. kafka.m5.large. ([Pricing info](https://aws.amazon.com/msk/pricing/))"
  type        = string
  default     = null
}
variable "storage_volume_size" {
  type    = number
}
#endregion

##region logs
variable "cloudwatch_logs_enabled" {
  description = "Indicates whether you want to enable or disable streaming broker logs to Cloudwatch Logs"
  type        = bool
  default     = false
}
variable "firehose_logs_enabled" {
  description = "Indicates whether you want to enable or disable streaming broker logs to Kinesis Data Firehose"
  type        = bool
  default     = false
}
variable "firehose_delivery_stream" {
  description = "Name of the Kinesis Data Firehose delivery stream to deliver logs to"
  type        = string
  default     = null
}
variable "s3_logs_enabled" {
  description = "Indicates whether you want to enable or disable streaming broker logs to S3"
  type        = bool
  default     = false
}
variable "s3_logs_bucket" {
  description = "Name of the S3 bucket to deliver logs to"
  type        = string
  default     = null
}
variable "s3_logs_prefix" {
  description = "Prefix to append to the folder name"
  type        = string
  default     = null
}
#endregion

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

#region configuration
variable "create_configuration" {
  description = "Determines whether to create a configuration"
  type        = bool
  default     = false
}

variable "configuration_arn" {
  description = "ARN of an externally created configuration to use"
  type        = string
  default     = null
}

variable "configuration_revision" {
  description = "Revision of the externally created configuration to use"
  type        = number
  default     = null
}

variable "configuration_name_suffix" {
  description = "Suffix string of configuration name"
  type        = string
  default     = "-config"
}

variable "configuration_server_properties" {
  description = "Contents of the server.properties file. Supported properties are documented in the [MSK Developer Guide](https://docs.aws.amazon.com/msk/latest/developerguide/msk-configuration-properties.html)"
  type        = string
  default     = <<PROPERTIES
default.replication.factor=3
min.insync.replicas=2
log.retention.hours=72
PROPERTIES
}
#endregion

#region prometheus config
variable "jmx_exporter_enabled" {
  description = "Indicates whether you want to enable or disable the JMX Exporter"
  type        = bool
  default     = false
}

variable "node_exporter_enabled" {
  description = "Indicates whether you want to enable or disable the Node Exporter"
  type        = bool
  default     = false
}
#endregion

#region securityGroup
variable "create_security_group" {
  description = "Determines whether to create a securityGroup"
  type        = bool
  default     = true
}

#endregion

variable "timeouts" {
  description = "Create, update, and delete timeout configurations for the cluster"
  type        = map(string)
  default     = {
    create : "120m"
    update : "120m"
    delete : "120m"
  }
}