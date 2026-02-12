provider "aws" {
  region = var.base_config.aws_region
}

data "local_file" "config_file" {
  filename = var.base_config.local_yaml_file_name
}

locals {
  env              = var.base_config.env
  yaml-config-data = yamldecode(data.local_file.config_file.content)
}

resource "aws_secretsmanager_secret" "zxc_microservices_config" {
  name        = "${local.env}/zxc/microservices/config"
  description = "microservices config"
  tags        = var.tags
}

resource "aws_secretsmanager_secret" "zxc_config" {
  name        = "${local.env}/zxc/config"
  description = "bigdata component config:glue/kda..."
  tags        = var.tags
}

resource "aws_secretsmanager_secret_version" "zxc_microservices_config_secret" {
  secret_id     = aws_secretsmanager_secret.zxc_microservices_config.id
  secret_string = jsonencode({
    "mysql_url" : "${var.rds_endpoint}",
    "mysql_user" : "",
    "mysql_pwd" : "",
    "redis_host" : "${var.redis_endpoint}",
    "redis_port" : "6379",
    "redis_pwd" : "${var.redis_pwd}",
    "redshift_read_url" : "${var.redshift_cluster_endpoint}",
    "redshift_read_username" : "",
    "redshift_read_password" : "",
    "s3_app_access_key_id" : "",
    "s3_app_access_key_secret" : "",
    "s3_app_bucket_name" : "",
    "s3_app_expiration" : "3600",
    "s3_endpoint" : "",
    "s3_region" : "${var.base_config.aws_region}"
  })

#  lifecycle {
#    ignore_changes = all
#  }
}


resource "aws_secretsmanager_secret_version" "zxc_config_secret" {
  secret_id     = aws_secretsmanager_secret.zxc_config.id
  secret_string = jsonencode({
    "vdp_flink_cicd_token" : "",
    "vdp_flink_gdpr_decrypt" : "",
    "vdp_flink_m241_decrypt" : "",
    "vdp_flink_rvs_decrypt" : "",
    "vdp_flink_redis_host" : "${var.redis_endpoint}",
    "vdp_flink_redis_port" : "6379",
    "vdp_flink_redis_pwd" : "${var.redis_pwd}",
    "vdp_flink_mysql_host" : "${var.rds_address}",
    "vdp_flink_mysql_port" : "${var.rds_port}",
    "vdp_flink_mysql_user" : "",
    "vdp_flink_mysql_pwd" : "",
    "vdp_redshift_write_host" : "${var.redshift_cluster_endpoint}",
    "vdp_redshift_write_port" : "${var.redshift_cluster_port}",
    "vdp_redshift_write_dbClusterIdentifier" : "${var.redshift_cluster_identifier}",
    "vdp_redshift_write_username" : "",
    "vdp_redshift_write_password" : "",
    "vdp_redshift_read_host" : "${var.redshift_cluster_endpoint}",
    "vdp_redshift_read_port" : "${var.redshift_cluster_port}",
    "vdp_redshift_read_dbClusterIdentifier" : "${var.redshift_cluster_identifier}",
    "vdp_redshift_read_username" : "",
    "vdp_redshift_read_password" : "",
    "vdp_front_kafka_broker" : "${var.front_kafka_bootstrap_brokers}",
    "vdp_back_kafka_broker" : "${var.back_kafka_bootstrap_brokers}",
    "decrypt.secret" : ""
  })

  #  lifecycle {
  #    ignore_changes = all
  #  }
}

