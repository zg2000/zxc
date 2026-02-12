resource "aws_redshift_parameter_group" "this" {
  count = var.create && var.create_parameter_group ? 1 : 0

  name   = "${var.cluster_identifier}-parameter-group"
  family = var.parameter_group_family
}

#region security_group
resource "aws_security_group" "this" {
  count       = var.create && var.create_security_group ? 1 : 0
  name        = "${var.cluster_identifier}-sg"
  description = "${var.cluster_identifier}-sg"
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
  parameter_group_name = var.create && var.create_parameter_group ?  aws_redshift_parameter_group.this[0].name : var.parameter_group_name

  vpc_security_group_ids = var.create && var.create_security_group ? [
    aws_security_group.this[0].id
  ] : var.vpc_security_group_ids
}


resource "aws_redshift_cluster" "this" {
  count = var.create ? 1 : 0

  cluster_identifier          = var.cluster_identifier
  database_name               = var.database_name
  port                        = var.port
  master_username             = var.username
  ##是否从快照恢复
  master_password             = var.snapshot_identifier != null ? null : var.password
  snapshot_cluster_identifier = var.snapshot_cluster_identifier
  snapshot_identifier         = var.snapshot_identifier
  skip_final_snapshot         = var.skip_final_snapshot
  final_snapshot_identifier   = var.skip_final_snapshot ? null : var.final_snapshot_identifier

  node_type       = var.node_type
  number_of_nodes = var.number_of_nodes
  cluster_type    = var.number_of_nodes > 1 ? "multi-node" : "single-node"

  cluster_parameter_group_name = local.parameter_group_name
  ##vpc
  cluster_subnet_group_name    = var.subnet_group_name
  vpc_security_group_ids       = local.vpc_security_group_ids

  ## encrypted
  encrypted  = var.kms_key_arn != null|| var.encrypted
  kms_key_id = var.kms_key_arn

  #optional
  allow_version_upgrade                = var.allow_version_upgrade
  apply_immediately                    = var.apply_immediately
  aqua_configuration_status            = var.aqua_configuration_status
  automated_snapshot_retention_period  = var.automated_snapshot_retention_period
  availability_zone                    = var.availability_zone
  availability_zone_relocation_enabled = var.availability_zone_relocation_enabled
  cluster_version                      = var.cluster_version
  enhanced_vpc_routing                 = var.enhanced_vpc_routing
  publicly_accessible                  = var.publicly_accessible

  # iam_roles and default_iam_roles are managed in the aws_redshift_cluster_iam_roles resource below
  dynamic "logging" {
    for_each = can(var.logging.enable) ? [var.logging] : []
    content {
      bucket_name          = try(logging.value.bucket_name, null)
      enable               = logging.value.enable
      log_destination_type = try(logging.value.log_destination_type, null)
      log_exports          = try(logging.value.log_exports, null)
      s3_key_prefix        = try(logging.value.s3_key_prefix, null)
    }
  }

  lifecycle {
    ignore_changes = [master_password]
  }
  tags = var.tags

  timeouts {
    create = "75m"
    update = "75m"
    delete = "40m"
  }
}

resource "aws_redshift_cluster_iam_roles" "this" {
  count = var.create && length(var.iam_role_arns) > 0 ? 1 : 0

  cluster_identifier   = aws_redshift_cluster.this[0].id
  iam_role_arns        = var.iam_role_arns
  default_iam_role_arn = var.default_iam_role_arn
}
