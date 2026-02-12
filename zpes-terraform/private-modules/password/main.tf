resource "random_password" "password" {
  length           = var.length
  special          = true
  override_special = "+_" # 不要使用-%$
  min_lower        = 1
  min_upper        = 1
  min_numeric      = 1
  min_special      = 1
}