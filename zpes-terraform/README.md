# msk_instance

after

List of Kafka topics that need to be created on the page:

| Topic                                      | Service                | number_of_partitions | replicas |
|--------------------------------------------|------------------------|----------------------|----------|
| zpes_sdb_version_update_notify_prod_topic  | zpes-admin             | 12                   | 2        |
| zpes_frontend_tracking_data_prod_topic     | zpes-metric            | 12                   | 2        |
| zpes_tracking_data_prod_topic              | zpes-metric            | 12                   | 2        |
| zpes_job_delay_prod_topic                  | zpes-job               | 12                   | 2        |
| zpes_job_partition_prod_topic              | zpes-job               | 4                    | 2        |
| zpes_edge_log_metadata_storage_prod_topic  | flink -> kafka -> glue | 12                   | 2        |
| zpes_edge_file_metadata_storage_prod_topic | flink -> kafka -> glue | 12                   | 2        |

# rds_instance

- DDL Script:
    - [DDL_zpes.sql](modules%2Fregional%2Frds_instance%2Fddl%2FDDL_zpes.sql)
- Insert Script:
    - need to check @HuiMeng

# rds_job_instance

- DDL Script:
    - [DDL_zpes_job.sql](modules%2Fregional%2Frds_job_instance%2Fddl%2FDDL_zpes_job.sql)

# Secrets Manager

> should be created on the console page

Secret name:
`prod/swe/zpes/config`

List of secret key (and value):

| Type      | Key                       | Value                                                                                                                                           |
|-----------|---------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------|
| Nacos     | zpes_nacos_host           | http://nacos-headless.nacos.svc.cluster.local:8848                                                                                              |
| Nacos     | zpes_nacos_username       | zpes                                                                                                                                            |
| Nacos     | zpes_nacos_password       | Will be created in the console.                                                                                                                 |
| mysql     | zpes_mysql_host           | Will be generated after executing ZPES Terraform                                                                                                |  
| mysql     | zpes_mysql_port           | Will be generated after executing ZPES Terraform                                                                                                |  
| mysql     | zpes_mysql_username       | Will be generated after executing ZPES Terraform                                                                                                |  
| mysql     | zpes_mysql_password       | Will be generated after executing ZPES Terraform                                                                                                |  
| mysql_job | zpes_mysql_job_host       | Will be generated after executing ZPES Terraform                                                                                                |  
| mysql_job | zpes_mysql_job_port       | Will be generated after executing ZPES Terraform                                                                                                |  
| mysql_job | zpes_mysql_job_username   | Will be generated after executing ZPES Terraform                                                                                                |  
| mysql_job | zpes_mysql_job_password   | Will be generated after executing ZPES Terraform                                                                                                |  
| redis     | zpes_redis_host           | Will be generated after executing ZPES Terraform                                                                                                |  
| redis     | zpes_redis_password       | Will be generated after executing ZPES Terraform                                                                                                |  
| redis     | zpes_redis_job_host       | Will be generated after executing ZPES Terraform                                                                                                |  
| redis     | zpes_redis_job_password   | Will be generated after executing ZPES Terraform                                                                                                |  
| kafka     | zpes_kafka_broker         | Will be generated after executing ZPES Terraform                                                                                                |  
| kafka     | zxc_external_kafka_broker | b-1.awszxceuexternalpro.hen66h.c4.kafka.eu-central-1.amazonaws.com:9092,b-2.awszxceuexternalpro.hen66h.c4.kafka.eu-central-1.amazonaws.com:9092 |  
| xxl_job   | zpes_xxl_job_host         | http://xxl-job:8055/xxl-job-admin                                                                                                               |  
| xxl_job   | zpes_xxl_job_access_token | Will be created in the console.                                                                                                                 |  
| redshift  | zpes_holo_host            | Will be generated after executing ZPES Terraform                                                                                                |  
| redshift  | zpes_holo_port            | Will be generated after executing ZPES Terraform                                                                                                |  
| redshift  | zpes_holo_username        | Will be generated after executing ZPES Terraform                                                                                                |  
| redshift  | zpes_holo_password        | Will be generated after executing ZPES Terraform                                                                                                |  
| zxc       | zxc_job_private_key       | Will be created in the console.                                                                                                                 |  
| zxc       | zxc_vehicle_private_key   | Will be created in the console.                                                                                                                 |