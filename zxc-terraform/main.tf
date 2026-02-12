provider "aws" {
  region = var.aws_region
}


locals {
  local_yaml_file_name = "environments/${var.env}/${var.dir_name}/config.yaml"
}

data "local_file" "config_file" {
  filename = local.local_yaml_file_name
}

locals {
  yaml-config-data = yamldecode(data.local_file.config_file.content)
  base_config      = {
    env                  = var.env
    aws_region           = var.aws_region
    aws_account_id       = var.aws_account_id
    local_yaml_file_name = local.local_yaml_file_name
  }
  tags = local.yaml-config-data.basic.tags
}

module "vpc" {
  source      = "./modules/regional/vpc"
  base_config = local.base_config
}

module "s3_bucket" {
  source      = "./modules/regional/s3_bucket"
  base_config = local.base_config
  tags        = local.tags
}

module "msk_instance" {
  source                     = "./modules/regional/msk_instance"
  base_config                = local.base_config
  private_subnet_ids         = module.vpc.private_subnet_ids
  vpc_id                     = module.vpc.default_vpc_id
  bigdata_msk_logs_s3_bucket = module.s3_bucket.aws_zxc_msk_logs_s3_bucket
  tags                       = local.tags
}

#module "rds_instance" {
#  source             = "./modules/regional/rds_instance"
#  base_config        = local.base_config
#  private_subnet_ids = module.vpc.private_subnet_ids
#  vpc_id             = module.vpc.default_vpc_id
#  zeekr_root_user    = var.zeekr_root_user
#  tags               = local.tags
#}
#
#module "redis_instance" {
#  source             = "./modules/regional/redis_instance"
#  base_config        = local.base_config
#  private_subnet_ids = module.vpc.private_subnet_ids
#  vpc_id             = module.vpc.default_vpc_id
#  tags               = local.tags
#}
module "iam_service_role" {
  source      = "./modules/global/iam_service_role"
  base_config = local.base_config

  aws_zxc_flink_s3_arn       = module.s3_bucket.aws_zxc_flink_s3_arn
  aws_zxc_flink_s3_bucket    = module.s3_bucket.aws_zxc_flink_s3_bucket
  aws_zxc_data_s3_bucket     = module.s3_bucket.aws_zxc_data_s3_bucket
  aws_zxc_lambda_s3_bucket   = module.s3_bucket.aws_zxc_lambda_s3_bucket
  aws_zxc_msk_logs_s3_bucket = module.s3_bucket.aws_zxc_msk_logs_s3_bucket
  aws_zxc_msk_logs_s3_arn    = module.s3_bucket.aws_zxc_msk_logs_s3_arn

  tags = local.tags
}

module "sqs_queue_instance" {
  source      = "./modules/regional/sqs_queue_instance"
  base_config = local.base_config

  aws_zxc_data_s3_bucket = module.s3_bucket.aws_zxc_data_s3_bucket
  aws_zxc_data_s3_arn    = module.s3_bucket.aws_zxc_data_s3_arn

  tags = local.tags
}

module "lambda_instance" {
  source                        = "./modules/regional/lambda_instance"
  base_config                   = local.base_config
  private_subnet_ids            = module.vpc.private_subnet_ids
  vpc_id                        = module.vpc.default_vpc_id
  sqs_arn                       = module.sqs_queue_instance.sqs_arn
  s3_arn                        = module.s3_bucket.aws_zxc_lambda_s3_arn
  aws_zxc_lambda_s3_bucket      = module.s3_bucket.aws_zxc_lambda_s3_bucket
  back_kafka_bootstrap_brokers  = module.msk_instance.back_msk_bootstrap_brokers
  front_kafka_bootstrap_brokers = module.msk_instance.front_msk_bootstrap_brokers
  aws_zxc_s3_data_sqs_arn       = module.sqs_queue_instance.sqs_arn
  aws_zxc_s3_data_bucket_name   = module.s3_bucket.aws_zxc_data_s3_bucket

  zxc_lambda_role_arn           = module.iam_service_role.zxc_lambda_service_role_arn
  vdp_front_kafka_brokers       = var.vdp_front_kafka_brokers

  tags                          = local.tags
}


module "flink_instance" {
  source                         = "./modules/regional/flink_instance"
  base_config                    = local.base_config
  tags                           = local.tags
  private_subnet_ids             = module.vpc.private_subnet_ids
  vpc_id                         = module.vpc.default_vpc_id
  aws_zxc_flink_s3_arn           = module.s3_bucket.aws_zxc_flink_s3_arn
  aws_zxc_flink_service_role_arn = module.iam_service_role.zxc_flink_service_role_arn

  ##config
  rds_address                   = "zxc-prod-mysql.cv08qxzwgoio.eu-central-1.rds.amazonaws.com"
  front_kafka_bootstrap_brokers = module.msk_instance.front_msk_bootstrap_brokers
  back_kafka_bootstrap_brokers  = module.msk_instance.back_msk_bootstrap_brokers
  vdp_front_kafka_brokers = var.vdp_front_kafka_brokers
}


## 组织安全组的关系
module "security_group_rule" {
  source      = "./modules/regional/security_group_rule"
  base_config = local.base_config
  vpc_id      = module.vpc.default_vpc_id
  tags        = local.tags

  #resource
  zxc_front_msk_sg_id = module.msk_instance.front_msk_security_group_id
  zxc_back_msk_sg_id  = module.msk_instance.back_msk_security_group_id

  zxc_flink_sg_id  = module.flink_instance.zxc_flink_sg_id
  zxc_lambda_sg_id = module.lambda_instance.zxc_lambda_sg_id
  vdp_front_msk_sg_id = var.vdp_front_kafka_sg_id
}