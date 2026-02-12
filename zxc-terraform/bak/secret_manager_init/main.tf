provider "aws" {
  region = var.base_config.aws_region
}

locals {
  env = var.base_config.env
}

resource "aws_secretsmanager_secret" "zxc_config" {
  name = "${local.env}/bigdata/vdp/config"
}

resource "aws_secretsmanager_secret_version" "zxc_config_secret" {
  secret_id     = aws_secretsmanager_secret.zxc_config.id
  secret_string = jsonencode({
    "vdp_flink_cicd_token" : "",
    "vdp_flink_rvs_decrypt" : "",
    "vdp_flink_rvs_decrypt_uat" : "",
    "vdp_flink_redis_host" : "",
    "vdp_flink_redis_port" : "6379",
    "vdp_flink_redis_pwd" : "",
    "vdp_flink_mysql_host" : "",
    "vdp_flink_mysql_port" : "3306",
    "vdp_flink_mysql_user" : "",
    "vdp_flink_mysql_pwd" : "",
    "vdp_redshift_write_host" : "",
    "vdp_redshift_write_port" : "",
    "vdp_redshift_write_dbClusterIdentifier" : "",
    "vdp_redshift_write_username" : "",
    "vdp_redshift_write_password" : "",
    "vdp_redshift_read_host" : "",
    "vdp_redshift_read_port" : "",
    "vdp_redshift_read_dbClusterIdentifier" : "",
    "vdp_redshift_read_username" : "1",
    "vdp_redshift_read_password" : "",
    "vdp_s3_endpoint" : "",
    "vdp_s3_region" : "",
    "vdp_s3_app_bucket_name" : "",
    "vdp_s3_app_access_key_id" : "",
    "vdp_s3_app_access_key_secret" : "",
    "vdp_s3_app_expiration" : "",
    "vdp_user_center_client_id" : "",
    "vdp_user_center_client_secret" : "",
    "vdp_flink_gdpr_decrypt" : "",
    "decrypt.secret" : "",
    "volvo_kaf_ssl_keystore_password" : "",
    "volvo_kaf_ssl_key_password" : "",
    "volvo_kaf_ssl_truststore_password" : "",
    "vdp_front_kafka_broker" : "",
    "vdp_back_kafka_broker" : "",
  })
  lifecycle {
    ignore_changes = [
      secret_string
    ]
  }
}

resource "aws_secretsmanager_secret" "zxc_query_redshift" {
  name = "${local.env}/bigdata/vdp/query/redshift"
  tags = {
    "Redshift" = "Redshift"
  }
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}


resource "aws_secretsmanager_secret_version" "zxc_query_redshift_secret" {
  secret_id     = aws_secretsmanager_secret.zxc_query_redshift.id
  secret_string = jsonencode({
    "dbClusterIdentifier" : "",
    "engine" : "redshift",
    "host" : "",
    "port" : "5439",
    "username" : "",
    "password" : ""
  })
  lifecycle {
    ignore_changes = [
      secret_string
    ]
  }
}


resource "aws_secretsmanager_secret" "zxc_microservices_config" {
  name = "${local.env}/bigdata/vdp/microservices/config"

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
resource "aws_secretsmanager_secret_version" "zxc_microservices_config_secret" {
  secret_id     = aws_secretsmanager_secret.zxc_microservices_config.id
  secret_string = jsonencode({
    "mysql_host" : "",
    "mysql_port" : "",
    "mysql_user" : "",
    "mysql_pwd" : "",
    "redis_host" : "",
    "redis_port" : "",
    "redis_pwd" : "",
    "redshift_read_url" : "",
    "redshift_read_username" : "",
    "redshift_read_password" : "",
    "s3_endpoint" : "",
    "s3_app_bucket_name" : "",
    "s3_app_access_key_id" : "",
    "s3_app_access_key_secret" : "",
    "s3_region" : "",
    "s3_app_expiration" : ""
  })
  lifecycle {
    ignore_changes = [
      secret_string
    ]
  }
}


