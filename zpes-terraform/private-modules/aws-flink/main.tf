#region CloudWatch Log Group
resource "aws_cloudwatch_log_group" "this" {
  count = var.create && var.create_cloudwatch_log_group ? 1 : 0

  name              = coalesce(var.cloudwatch_log_group_name, "/aws/msk/zpes-flink-logs")
  retention_in_days = var.cloudwatch_log_group_retention_in_days
  tags              = var.tags
}
#endregion


#region security_group
resource "aws_security_group" "this" {
  count       = var.create && var.create_security_group ? 1 : 0
  name        = "${var.name}-sg"
  description = "${var.name}-sg"
  vpc_id      = var.vpc_id
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
  cloudwatch_log_group = var.create && var.create_cloudwatch_log_group ? aws_cloudwatch_log_group.this[0].name : var.cloudwatch_log_group_name
  security_groups      = var.create && var.create_security_group ? [
    aws_security_group.this[0].id
  ] : var.vpc_security_group_ids
}

resource "aws_cloudwatch_log_stream" "this" {
  count          = var.create ? 1 : 0
  log_group_name = local.cloudwatch_log_group
  name           = "${var.name}_log_stream"
}

resource "aws_kinesisanalyticsv2_application" "this" {
  count = var.create ? 1 : 0

  name                   = var.name
  runtime_environment    = var.runtime_environment
  service_execution_role = var.service_execution_role

  #region app config
  application_configuration {

    vpc_configuration {
      subnet_ids         = var.private_subnet_ids
      security_group_ids = local.security_groups
    }

    ## region code config
    application_code_configuration {
      code_content {
        s3_content_location {
          bucket_arn = var.code_config.bucket_arn
          file_key   = var.code_config.file_key
        }
      }
      code_content_type = try(var.code_config.code_content_type, "ZIPFILE")
    }
    ## endregion
    ## region  property
    environment_properties {
      property_group {
        property_group_id = var.property_group_id
        property_map      = var.property_map
      }
    }
    ## endregion

    flink_application_configuration {
      checkpoint_configuration {
        configuration_type            = var.checkpoint_config.configuration_type
        checkpointing_enabled         = var.checkpoint_config.checkpointing_enabled
        checkpoint_interval           = var.checkpoint_config.checkpoint_interval
        min_pause_between_checkpoints = var.checkpoint_config.min_pause_between_checkpoints
      }

      monitoring_configuration {
        configuration_type = var.monitoring_config.configuration_type
        log_level          = var.monitoring_config.log_level
        metrics_level      = var.monitoring_config.metrics_level
      }

      parallelism_configuration {
        configuration_type   = var.parallelism_config.configuration_type
        auto_scaling_enabled = var.parallelism_config.auto_scaling_enabled
        parallelism          = var.parallelism_config.parallelism
        parallelism_per_kpu  = var.parallelism_config.parallelism_per_kpu
      }
    }
  }
  #endregion
  cloudwatch_logging_options {
    log_stream_arn = aws_cloudwatch_log_stream.this[0].arn
  }

  lifecycle {
    ignore_changes = [
      application_configuration
    ]
  }
  tags = var.tags
}
