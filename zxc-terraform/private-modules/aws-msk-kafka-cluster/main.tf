#region Configuration
resource "aws_msk_configuration" "this" {
  count = var.create && var.create_configuration ? 1 : 0

  name              = "${var.name}${var.configuration_name_suffix}"
  description       = "${var.name}${var.configuration_name_suffix}"
  kafka_versions    = [var.kafka_version]
  server_properties = var.configuration_server_properties
}
#endregion

#region CloudWatch Log Group
locals {
  cloudwatch_log_group = var.create && var.create_cloudwatch_log_group ? aws_cloudwatch_log_group.this[0].name : var.cloudwatch_log_group_name
}

resource "aws_cloudwatch_log_group" "this" {
  count = var.create && var.create_cloudwatch_log_group ? 1 : 0

  name              = coalesce(var.cloudwatch_log_group_name, "/aws/msk/${var.name}")
  retention_in_days = var.cloudwatch_log_group_retention_in_days
  tags              = var.tags
}
#endregion

#region security_group
resource "aws_security_group" "this" {
  count       = var.create && var.create_security_group ? 1 : 0
  name        = "${var.name}-sg"
  description = "${var.name}-sg"
  vpc_id      = var.broker_node_client_vpc_id
  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    self      = true
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.tags
  lifecycle {
    ignore_changes = all
  }
}
#endregion

locals {
  security_groups = var.create && var.create_security_group ? [
    aws_security_group.this[0].id
  ] : var.broker_node_security_groups

  configuration_arn      = var.create && var.create_configuration ? aws_msk_configuration.this[0].arn : var.configuration_arn
  configuration_revision = var.create && var.create_configuration ? aws_msk_configuration.this[0].latest_revision : var.configuration_revision
}

#region Cluster
resource "aws_msk_cluster" "this" {
  count = var.create ? 1 : 0

  cluster_name           = var.name
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.number_of_broker_nodes
  enhanced_monitoring    = var.enhanced_monitoring

  storage_mode = var.storage_mode

  broker_node_group_info {
    client_subnets  = var.broker_node_client_subnets
    security_groups = local.security_groups
    instance_type   = var.broker_node_instance_type
    storage_info {
      ebs_storage_info {
        volume_size = var.storage_volume_size
      }
    }
  }

  client_authentication {
    unauthenticated = true
    sasl {
      iam   = false
      scram = false
    }
    #    tls {}
  }

  configuration_info {
    arn      = local.configuration_arn
    revision = local.configuration_revision
  }

  encryption_info {
    encryption_in_transit {
      client_broker = "PLAINTEXT"
    }
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = var.cloudwatch_logs_enabled
        log_group = var.cloudwatch_logs_enabled ? local.cloudwatch_log_group : null
      }

      firehose {
        enabled         = var.firehose_logs_enabled
        delivery_stream = var.firehose_delivery_stream
      }
      s3 {
        bucket  = var.s3_logs_bucket
        enabled = var.s3_logs_enabled
        prefix  = var.s3_logs_prefix
      }
    }
  }


  open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = var.jmx_exporter_enabled
      }
      node_exporter {
        enabled_in_broker = var.node_exporter_enabled
      }
    }
  }


  timeouts {
    create = try(var.timeouts.create, null)
    update = try(var.timeouts.update, null)
    delete = try(var.timeouts.delete, null)
  }

  lifecycle {
    ignore_changes = [
      cluster_name
    ]
  }

  tags = var.tags
}
#endregion

