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

locals {
  default_vpc_id                    = module.vpc.default_vpc_id
  private_subnet_ids                = module.vpc.private_subnet_ids
  private_subnet_availability_zones = module.vpc.private_subnet_availability_zones
  public_subnet_ids                 = module.vpc.public_subnet_ids
}

module "s3_bucket" {
  source      = "./modules/regional/s3_bucket"
  base_config = local.base_config
  tags        = local.tags
}

module "msk_instance" {
  source                  = "./modules/regional/msk_instance"
  base_config             = local.base_config
  private_subnet_ids      = local.private_subnet_ids
  vpc_id                  = local.default_vpc_id
  zpes_msk_logs_s3_bucket = module.s3_bucket.swe_zpes_msk_logs_s3_bucket
  tags                    = local.tags
}

module "rds_instance" {
  source             = "./modules/regional/rds_instance"
  base_config        = local.base_config
  private_subnet_ids = local.private_subnet_ids
  vpc_id             = local.default_vpc_id
  zeekr_root_user    = var.zeekr_root_user
  tags               = merge(local.tags)
}

module "rds_job_instance" {
  source             = "./modules/regional/rds_job_instance"
  base_config        = local.base_config
  private_subnet_ids = local.private_subnet_ids
  vpc_id             = local.default_vpc_id
  zeekr_root_user    = var.zeekr_root_user
  tags               = merge(local.tags)
}

module "redis_instance" {
  source             = "./modules/regional/redis_instance"
  base_config        = local.base_config
  private_subnet_ids = local.private_subnet_ids
  vpc_id             = local.default_vpc_id
  tags               = local.tags
}

module "redshift_instance" {
  source             = "./modules/regional/redshift_instance"
  base_config        = local.base_config
  private_subnet_ids = local.private_subnet_ids
  vpc_id             = local.default_vpc_id
  zeekr_root_user    = var.zeekr_root_user
  tags               = local.tags
}

data "aws_redshift_cluster" "vdp_redshift" {
  cluster_identifier = "aws-zd-vdp-eu-data-prod-redshift"
}

data "aws_msk_cluster" "zxc_kafka" {
  cluster_name = "aws-zxc-eu-internal-${local.base_config.env}-kafka"
}

module "iam_service_role" {
  source      = "./modules/global/iam_service_role"
  base_config = local.base_config

  swe_zpes_flink_s3_arn    = module.s3_bucket.swe_zpes_flink_s3_arn
  swe_zpes_flink_s3_bucket = module.s3_bucket.swe_zpes_flink_s3_bucket
  swe_zpes_glue_s3_arn     = module.s3_bucket.swe_zpes_glue_s3_arn
  swe_zpes_glue_s3_bucket  = module.s3_bucket.swe_zpes_glue_s3_bucket

  swe_zpes_redshift_arn   = data.aws_redshift_cluster.vdp_redshift.arn
  swe_zpes_kafka_arn_list = [data.aws_msk_cluster.zxc_kafka.arn]
  swe_zpes_rds_arn_list   = [module.rds_instance.rds_arn]

  tags = local.tags
}

module "security_group" {
  source      = "./modules/regional/security_group"
  base_config = local.base_config
  vpc_id      = local.default_vpc_id
  tags        = local.tags
}

module "secret_manager_init" {
  source      = "./modules/regional/secret_manager_init"
  base_config = local.base_config
  tags        = local.tags

  secret_string = jsonencode({
    "zpes_nacos_host" : "http://nacos-headless.nacos.svc.cluster.local:8848",
    "zpes_nacos_username" : "zpes",
    "zpes_nacos_password" : "Will be created in the console.",

    "zpes_mysql_host" : module.rds_instance.rds_address,
    "zpes_mysql_port" : module.rds_instance.rds_port,
    "zpes_mysql_username" : module.rds_instance.rds_username,
    "zpes_mysql_password" : module.rds_instance.rds_password,

    "zpes_mysql_job_host" : module.rds_job_instance.rds_address,
    "zpes_mysql_job_port" : module.rds_job_instance.rds_port,
    "zpes_mysql_job_username" : module.rds_job_instance.rds_username,
    "zpes_mysql_job_password" : module.rds_job_instance.rds_password,

    "zpes_redis_host" : module.redis_instance.redis_endpoint,
    "zpes_redis_password" : module.redis_instance.redis_password,

    "zpes_redis_job_host" : module.redis_instance.redis_endpoint,
    "zpes_redis_job_password" : module.redis_instance.redis_password,

    "zpes_kafka_broker" : module.msk_instance.front_msk_bootstrap_brokers,
    "zxc_external_kafka_broker" : "b-1.awszxceuexternalpro.hen66h.c4.kafka.eu-central-1.amazonaws.com:9092,b-2.awszxceuexternalpro.hen66h.c4.kafka.eu-central-1.amazonaws.com:9092",

    "zpes_xxl_job_host" : "http://xxl-job:8055/xxl-job-admin",
    "zpes_xxl_job_access_token" : "Will be created in the console.",

    "zpes_holo_host" : module.redshift_instance.redshift_cluster_endpoint,
    "zpes_holo_port" : module.redshift_instance.redshift_cluster_port,
    "zpes_holo_username" : module.redshift_instance.redshift_cluster_username,
    "zpes_holo_password" : module.redshift_instance.redshift_cluster_password,

    "zxc_job_private_key" : "Will be created in the console.",
    "zxc_vehicle_private_key" : "Will be created in the console.",
  })
}

module "flink_instance" {
  source                          = "./modules/regional/flink_instance"
  base_config                     = local.base_config
  tags                            = local.tags
  private_subnet_ids              = local.private_subnet_ids
  vpc_id                          = local.default_vpc_id
  zpes_flink_s3_arn               = module.s3_bucket.swe_zpes_flink_s3_arn
  swe_zpes_flink_service_role_arn = module.iam_service_role.swe_zpes_flink_service_role_arn
  rds_security_group_id           = module.rds_instance.rds_security_group_id

  ##config
  vehicleJdbcUrl            = "jdbc:mysql://zxc-prod-mysql.cv08qxzwgoio.eu-central-1.rds.amazonaws.com:3306/vehicledb?useUnicode=true&characterEncoding=UTF-8"
  zpesJdbcUrl               = "jdbc:mysql://${module.rds_instance.rds_address}:${module.rds_instance.rds_port}/${module.rds_instance.rds_db_name}?useUnicode=true&characterEncoding=UTF-8"

  ossBucketName             = "aws-zxc-eu-data-prod-s3"
  zpesKafkaBootstrapServers = module.msk_instance.front_msk_bootstrap_brokers
  kafkaTopicOfFileMetadata  = "zpes_edge_file_metadata_storage_${var.env}_topic"
  kafkaTopicOfLogMetadata   = "zpes_edge_log_metadata_storage_${var.env}_topic"
}

module "glue_instance" {
  source                            = "./modules/regional/glue_instance"
  base_config                       = local.base_config
  tags                              = local.tags
  private_subnet_ids                = local.private_subnet_ids
  private_subnet_availability_zones = local.private_subnet_availability_zones
  vpc_id                            = local.default_vpc_id
  swe_zpes_glue_s3_bucket           = module.s3_bucket.swe_zpes_glue_s3_bucket
  swe_zpes_glue_s3_arn              = module.s3_bucket.swe_zpes_glue_s3_arn
  swe_zpes_glue_service_role_arn    = module.iam_service_role.swe_zpes_glue_service_role_arn
}

## 组织安全组的关系
module "security_group_rule" { #TODO: help, may not working
  source      = "./modules/regional/security_group_rule"
  base_config = local.base_config
  vpc_id      = local.default_vpc_id
  tags        = local.tags

  #resource
  swe_zpes_front_msk_sg_id = module.msk_instance.front_msk_security_group_id
  #swe_zpes_redshift_sg_id  = module.redshift_instance.redshift_security_group_id
  swe_zpes_rds_sg_id       = module.rds_instance.rds_security_group_id

  swe_zpes_flink_sg_id = module.flink_instance.swe_zpes_flink_sg_id
  swe_zpes_glue_sg_id  = module.glue_instance.swe_zpes_glue_sg_id
}


module "iam_user_group" { #TODO: help, may no need to exist
  source      = "./modules/global/iam_user_group"
  base_config = local.base_config

  #resource
  swe_zpes_kafka_arn_list            = [module.msk_instance.front_msk_arn]
  swe_zpes_redshift_cluster_arn_list = [module.redshift_instance.redshift_cluster_arn]
  swe_zpes_rds_arn_list              = [module.rds_instance.rds_arn]
  swe_zpes_redis_arn_list            = [module.redis_instance.redis_arn]

  swe_zpes_pass_role_list = module.iam_service_role.swe_zpes_pass_role_list
}

#TODO: help, may need to modify (serviceaccount is not zxc)
data "aws_iam_role" "zpes_sa_role" {
  name = "EksSecretsProviderRole-zxc_prod"
}

#TODO: help, if ZPES's aws_iam_role is created include s3 policy, there will be no need to append one.
resource "aws_iam_role_policy_attachment" "apply_s3_policy_to_zpes_sa" {
  role       = data.aws_iam_role.zpes_sa_role.name
  policy_arn = "arn:aws:iam::039287201034:policy/aws-zpes-eu-test-all-s3-rw-policy"
}