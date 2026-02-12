resource "aws_security_group" "this" {
  name        = var.name
  description = var.name
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
  tags = {
    Name = var.name
  }
  lifecycle {
    ignore_changes = all
  }
}
