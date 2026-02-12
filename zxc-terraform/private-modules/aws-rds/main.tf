resource "aws_db_parameter_group" "this" {
  count = var.create && var.create_parameter_group ? 1 : 0

  name   = "${var.identifier}-parameter-group"
  family = var.parameter_group_family
}

#region security_group
resource "aws_security_group" "this" {
  count       = var.create && var.create_security_group ? 1 : 0
  name        = "${var.identifier}-sg"
  description = "${var.identifier}-sg"
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
  name  = "${var.identifier}-zeekrsecret"
  lifecycle {
    ignore_changes = all
  }
}
resource "aws_secretsmanager_secret_version" "this" {
  count         = var.create ? 1 : 0
  secret_id     = aws_secretsmanager_secret.this[0].id
  secret_string = jsonencode({
    "user" : var.username
    "password" : var.password
  })
  lifecycle {
    ignore_changes = all
  }
}
#endregion


locals {
  parameter_group_name   = var.create && var.create_parameter_group ?  aws_db_parameter_group.this[0].name : var.parameter_group_name
  vpc_security_group_ids = var.create && var.create_security_group ? [
    aws_security_group.this[0].id
  ] : var.vpc_security_group_ids
}

resource "aws_db_instance" "this" {
  count = var.create ? 1 : 0

  identifier        = var.identifier
  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  db_name           = var.db_name
  username          = var.username
  password          = var.password

  # vpc &  parameter
  parameter_group_name   = local.parameter_group_name
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = local.vpc_security_group_ids
  multi_az               = var.multi_az

  backup_retention_period         = var.backup_retention_period
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  timeouts {
    create = lookup(var.timeouts, "create", null)
    delete = lookup(var.timeouts, "delete", null)
    update = lookup(var.timeouts, "update", null)
  }
  tags = var.tags
}
