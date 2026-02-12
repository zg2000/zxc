resource "aws_elasticache_parameter_group" "this" {
  count = var.create && var.create_parameter_group ? 1 : 0

  name   = "${var.name}-parameter-group"
  family = var.parameter_group_family
}


#region CloudWatch Log Group
locals {
  cloudwatch_log_group = var.create && var.create_cloudwatch_log_group ? aws_cloudwatch_log_group.this[0].name : var.cloudwatch_log_group_name
}

resource "aws_cloudwatch_log_group" "this" {
  count = var.create && var.create_cloudwatch_log_group ? 1 : 0

  name              = "/aws/redis-logs/${var.name}"
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

#region aws_secretsmanager_secret
resource "aws_secretsmanager_secret" "this" {
  count = var.create ? 1 : 0
  name  = "${var.name}-zeekrsecret"
  lifecycle {
    ignore_changes = all
  }
}
resource "aws_secretsmanager_secret_version" "this" {
  count         = var.create ? 1 : 0
  secret_id     = aws_secretsmanager_secret.this[0].id
  secret_string = jsonencode({
    "password" : var.password
  })
  lifecycle {
    ignore_changes = all
  }
}
#endregion

locals {
  parameter_group_name = var.create && var.create_parameter_group ?  aws_elasticache_parameter_group.this[0].name : var.parameter_group_name

  vpc_security_group_ids = var.create && var.create_security_group ? [
    aws_security_group.this[0].id
  ] : var.vpc_security_group_ids
}


resource "aws_elasticache_replication_group" "this" {
  count = var.create ? 1 : 0
  ##basic info
  replication_group_id       = var.name
  description                = var.name
  automatic_failover_enabled = var.num_cache_clusters>1 && var.automatic_failover_enabled
  multi_az_enabled           = var.num_cache_clusters>1 && var.multi_az_enabled
  node_type                  = var.node_type
  ## Redis Cluster Mode Disabled 缓存节点都位于一个节点组中，没有数据分片
  #  num_node_groups      = 2
  #Redis Cluster Mode Enabled 数据被分片到多个缓存节点（分片节点）中，以提高写入和存储能力
  num_cache_clusters         = var.num_cache_clusters
  parameter_group_name       = local.parameter_group_name
  port                       = var.port
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  engine                     = var.engine
  engine_version             = var.engine_version

  transit_encryption_enabled = true
  auth_token                 = var.password

  ##vpc
  subnet_group_name  = var.subnet_group_name
  security_group_ids = var.vpc_security_group_ids
  log_delivery_configuration {
    destination      = local.cloudwatch_log_group
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "slow-log"
  }
  timeouts {
    create = lookup(var.timeouts, "create", null)
    delete = lookup(var.timeouts, "delete", null)
    update = lookup(var.timeouts, "update", null)
  }
  lifecycle {
    ignore_changes = [
      log_delivery_configuration, subnet_group_name, security_group_ids, auth_token
    ]
  }
  depends_on = [aws_secretsmanager_secret_version.this]
}


