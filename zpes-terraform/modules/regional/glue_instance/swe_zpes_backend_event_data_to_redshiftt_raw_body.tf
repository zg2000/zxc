##script
data "template_file" "raw_body_backend_event_data" {
  template = file("${path.module}/script/zpes_backend_event_data_to_redshift.py")
  vars     = {
    aws_region                     = var.base_config.aws_region
    secret_name                    = "${local.env}/swe/zpes/config"
    swe_zpes_glue_service_role_arn = local.swe_zpes_glue_service_role_arn
    swe_zpes_glue_s3_bucket        = local.swe_zpes_glue_s3_bucket
  }
}

locals {
  job_name_backend_event_data         = "${local.env}_zpes_backend_event_data_to_redshift"
  kafka_topic_backend_event_data = "zpes_tracking_data_${local.env}_topic"
  kafka_group_name_backend_event_data = "zpes_tracking_data_${local.env}_group"
}
resource "aws_s3_object" "zpes_backend_event_data_to_redshift" {
  #  count = try(local.m241-zpes-all-data.create, false) ?1 : 0
  count   = 1
  bucket  = local.swe_zpes_glue_s3_bucket
  key     = "glue/scripts/${local.job_name_backend_event_data}.py"
  content = data.template_file.raw_body_backend_event_data.rendered
}
resource "aws_glue_job" "zpes_backend_event_data_to_redshift" {
  #  count = try(local.zpes_backend_event_data_to_redshift.create, false) ?1 : 0
  count = 1

  name     = local.job_name_backend_event_data
  role_arn = local.swe_zpes_glue_service_role_arn
  tags     = var.tags

  glue_version      = "4.0"
  worker_type       = "G.1X"
  number_of_workers = "2"
  command {
    name            = "gluestreaming"
    script_location = "s3://${local.swe_zpes_glue_s3_bucket}/glue/scripts/${local.job_name_backend_event_data}.py"
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
    "--TempDir": "s3://${local.swe_zpes_glue_s3_bucket}/glue/temporary/${local.job_name_backend_event_data}/",
    "--consumerGroup": "${local.kafka_group_name_backend_event_data}",
    "--extra-jars": "s3://${local.swe_zpes_glue_s3_bucket}/glue/dependent/spark3.3-sql-kafka-offset-committer-1.0.jar",
    "--enable-spark-ui": "true",
    "--spark-event-logs-path": "s3://${local.swe_zpes_glue_s3_bucket}/glue/sparkHistoryLogs/${local.job_name_backend_event_data}/",
    "--checkpointInterval": "30",
    "--checkpointLocation": "s3://${local.swe_zpes_glue_s3_bucket}/glue/checkpoint/${local.job_name_backend_event_data}/",
    "--enable-job-insights": "false",
    "--topic": "${local.kafka_topic_backend_event_data}",
    "--enable-continuous-cloudwatch-log": "true",
    "--job-language": "python"
  }
  lifecycle {
    ignore_changes = [
      max_retries, execution_class
    ]
  }
}

