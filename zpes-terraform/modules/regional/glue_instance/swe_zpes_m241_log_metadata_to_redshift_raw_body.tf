##script
data "template_file" "raw_body_log_metadata" {
  template = file("${path.module}/script/zpes_m241_log_metadata_to_redshift.py")
  vars     = {
    aws_region                     = var.base_config.aws_region
    secret_name                    = "${local.env}/swe/zpes/config"
    swe_zpes_glue_service_role_arn = local.swe_zpes_glue_service_role_arn
    swe_zpes_glue_s3_bucket        = local.swe_zpes_glue_s3_bucket
  }
}

locals {
  job_name_log_metadata         = "${local.env}_zpes_m241_log_metadata_to_redshift"
  kafka_topic_log_metadata = "zpes_edge_log_metadata_storage_${local.env}_topic"
  kafka_group_name_log_metadata = "zpes_edge_log_metadata_storage_${local.env}_group"
}
resource "aws_s3_object" "zpes_m241_log_metadata_to_redshift" {
  #  count = try(local.m241-zpes-all-data.create, false) ?1 : 0
  count   = 1
  bucket  = local.swe_zpes_glue_s3_bucket
  key     = "glue/scripts/${local.job_name_log_metadata}.py"
  content = data.template_file.raw_body_log_metadata.rendered
}
resource "aws_glue_job" "zpes_m241_log_metadata_to_redshift" {
  #  count = try(local.zpes_m241_log_metadata_to_redshift.create, false) ?1 : 0
  count = 1

  name     = local.job_name_log_metadata
  role_arn = local.swe_zpes_glue_service_role_arn
  tags     = var.tags

  glue_version      = "4.0"
  worker_type       = "G.1X"
  number_of_workers = "2"
  command {
    name            = "gluestreaming"
    script_location = "s3://${local.swe_zpes_glue_s3_bucket}/glue/scripts/${local.job_name_log_metadata}.py"
    python_version  = "3"
  }
  max_retries = 0
  connections = [
    aws_glue_connection.swe_zpes_network.name
  ]

  default_arguments = {
    "--startingOffsets": "earliest",
    "--enable-glue-datacatalog": "true",
    "--job-bookmark-option": "job-bookmark-disable",
    "--TempDir": "s3://${local.swe_zpes_glue_s3_bucket}/glue/temporary/${local.job_name_log_metadata}/",
    "--consumerGroup": "${local.kafka_group_name_log_metadata}",
    "--extra-jars": "s3://${local.swe_zpes_glue_s3_bucket}/glue/dependent/spark3.3-sql-kafka-offset-committer-1.0.jar",
    "--enable-spark-ui": "true",
    "--spark-event-logs-path": "s3://${local.swe_zpes_glue_s3_bucket}/glue/sparkHistoryLogs/${local.job_name_log_metadata}/",
    "--checkpointInterval": "30",
    "--checkpointLocation": "s3://${local.swe_zpes_glue_s3_bucket}/glue/checkpoint/${local.job_name_log_metadata}/",
    "--enable-job-insights": "false",
    "--topic": "${local.kafka_topic_log_metadata}",
    "--enable-continuous-cloudwatch-log": "true",
    "--job-language": "python"
  }
  lifecycle {
    ignore_changes = [
      max_retries, execution_class
    ]
  }
}

