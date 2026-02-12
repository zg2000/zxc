import sys
import boto3
import json
from botocore.exceptions import ClientError
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from pyspark.context import SparkConf
from pyspark.sql import DataFrame
from pyspark.sql import SparkSession
from awsglue.context import GlueContext
from pyspark.sql.types import StructType, StructField, StringType, IntegerType, ArrayType, MapType, LongType, DateType, TimestampType
from pyspark.sql.functions import from_json, col, to_json, json_tuple

from awsglue.job import Job

def get_secret():
    secret_name = "uat/swe/zpes/config"
    region_name = "eu-central-1"

    # Create a Secrets Manager client
    session = boto3.session.Session()
    client = session.client(
        service_name='secretsmanager',
        region_name=region_name
    )

    try:
        get_secret_value_response = client.get_secret_value(
            SecretId=secret_name
        )
    except ClientError as e:
        raise e

    secret = get_secret_value_response['SecretString']
    return secret


secret_dict = json.loads(get_secret())

params = [
    'JOB_NAME',
    # 'JOB_RUN_ID',
    'TempDir',
    'topic',
    'consumerGroup',
    'startingOffsets',
    'checkpointInterval',
    'checkpointLocation'
]

## @params: [JOB_NAME]
args = getResolvedOptions(sys.argv, params)
conf = SparkConf()

sc = SparkContext(conf=conf)
glueContext = GlueContext(sc)
spark = glueContext.spark_session
logger = glueContext.get_logger()
# job_name = args['JOB_NAME']
jobRunId = args['JOB_RUN_ID']
topic = args['topic']
consumerGroup = args['consumerGroup']
startingOffsets = args['startingOffsets']
checkpointInterval = args['checkpointInterval']
checkpointLocation = args['checkpointLocation']
aws_region = "eu-central-1"

kafkaBroker = secret_dict['zpes_back_kafka_broker']
logger.info(jobRunId + " - zpes_glue_log - kafkaBroker: " + kafkaBroker)

logger.info(jobRunId + " - zpes_glue_log - args: " + json.dumps(args))

# super or flatten
complex_convert = "super"

maxerror = 0
redshift_host = secret_dict['zpes_redshift_write_host']
redshift_port = secret_dict['zpes_redshift_write_port']
redshift_username = secret_dict['zpes_redshift_write_username']
redshift_password = secret_dict['zpes_redshift_write_password']
redshift_database = "zpes"
redshift_schema = "public"
redshift_table = "ods_m241_log_file_metadata"
redshift_tmpdir = "s3://aws-zpes-eu-glue-uat-s3/glue/temporary/glue-msk-redshift/"
tempformat = "CSV"
redshift_iam_role = "arn:aws:iam::039287201034:role/uat-swe-zpes-glue-service-role"

reader = spark \
    .readStream \
    .format("kafka") \
    .option("kafka.bootstrap.servers", kafkaBroker) \
    .option("subscribe", topic) \
    .option("groupId", consumerGroup)
# .option("maxOffsetsPerTrigger", "1000000") \
# .option("kafka.consumer.commit.groupid", consumerGroup) \
# .option("failOnDataLoss", "false")

if startingOffsets == "earliest" or startingOffsets == "latest":
    reader.option("startingOffsets", startingOffsets)
    logger.info(jobRunId + " - zpes_glue_log - set consume option - startingOffsets: " + startingOffsets)
else:
    reader.option("startingTimestamp", startingOffsets)
    logger.info(jobRunId + " - zpes_glue_log - set consume option - startingTimestamp: " + startingOffsets)

kafka_data = reader.load()
df = kafka_data.selectExpr("CAST(value AS STRING)")


def process_batch(data_frame, batchId):
    try:
        dfc = data_frame.cache()
        logger.info(jobRunId + " - zpes_glue_log - process_batch_try - batchId: " + str(batchId) + ", record count: " + str(dfc.count()))
        if not data_frame.rdd.isEmpty():
            # 定义外层schema
            json_schema = StructType([
                StructField("id",               StringType(),   True),
                StructField("pt",               StringType(),   True),
                StructField("vin",              StringType(),   True),
                StructField("dataType",         StringType(),   True),
                StructField("bucketName",       StringType(),   True),
                StructField("fileName",         StringType(),   True),
                StructField("size",             StringType(),   True),
                StructField("path",             StringType(),   True),
                StructField("uploadTimeReal",   StringType(),   True),
                StructField("modelId",          StringType(),   True),
                StructField("modelName",        StringType(),   True)
            ])
            sdf = dfc.select(from_json(col("value"), json_schema).alias("kdata")).select("kdata.*")
            source_view_name = "kafka_source_table_view"
            sdf.createOrReplaceGlobalTempView(source_view_name)
            sdf = spark.sql("select id, pt, vin as vehicle_no, bucketName as bucket_name, path as file_path, fileName as file_name, CAST(size AS bigint) as file_size, modelId as model_id, modelName as model_name, CAST(DATE_FORMAT(uploadTimeReal, 'yyyy-MM-dd HH:mm:ss') AS timestamp) AS upload_time, CURRENT_TIMESTAMP() AS create_time from {view_name}".format(view_name="global_temp." + source_view_name))
            logger.info(jobRunId + " - zpes_glue_log - source sdf schema: " + sdf._jdf.schema().treeString())
            logger.info(jobRunId + " - zpes_glue_log - source sdf: " + sdf._jdf.showString(5, 20, False))
            if complex_convert == "super":
                csdf = to_super_df(spark, sdf)
            elif complex_convert == "flatten":
                csdf = flatten_json_df(sdf)
            else:
                csdf = to_super_df(spark, flatten_json_df(sdf))
            logger.info(jobRunId + " - zpes_glue_log - convert csdf schema: " + csdf._jdf.schema().treeString())
            logger.info(jobRunId + " - zpes_glue_log - convert csdf: " + csdf._jdf.showString(5, 30, False))
            if not csdf.rdd.isEmpty():
                csdf.write \
                    .format("io.github.spark_redshift_community.spark.redshift") \
                    .option("url", "jdbc:redshift://{0}:{1}/{2}".format(redshift_host, redshift_port, redshift_database)) \
                    .option("dbtable", "{0}.{1}".format(redshift_schema, redshift_table)) \
                    .option("user", redshift_username) \
                    .option("password", redshift_password) \
                    .option("tempdir", redshift_tmpdir) \
                    .option("tempformat", tempformat) \
                    .option("extracopyoptions", "TRUNCATECOLUMNS region '{0}' maxerror {1} dateformat 'auto' timeformat 'auto'".format(
                    aws_region, maxerror)) \
                    .option("aws_iam_role", redshift_iam_role).mode("append").save()
            dfc.unpersist()
            logger.info(jobRunId + " - zpes_glue_log - finish batch id: " + str(batchId))
    except Exception as e:
        logger.error(jobRunId + " - zpes_glue_log - process_batch_error - batchId: " + str(batchId) + ", exception: " + str(e))
    finally:
        logger.info(jobRunId + " - zpes_glue_log - process_batch_finally")

def to_super_df(spark: SparkSession, _df: DataFrame) -> DataFrame:
    col_list = []
    for field in _df.schema.fields:

        if field.dataType.typeName() in ["struct", "array", "map"]:
            col_list.append("to_json({col}) as aws_super_{col}".format(col=field.name))
        else:
            col_list.append(field.name)
    view_name = "aws_source_table"
    _df.createOrReplaceGlobalTempView(view_name)
    df_json_str = spark.sql(
        "select {columns} from {view_name}".format(columns=",".join(col_list), view_name="global_temp." + view_name))

    fields = []
    for field in df_json_str.schema.fields:
        if "aws_super_" in field.name:
            sf = StructField(field.name.replace("aws_super_", ""), field.dataType, field.nullable,
                             metadata={"super": True, "redshift_type": "super"})
        else:
            sf = StructField(field.name, field.dataType, field.nullable)
        fields.append(sf)
    schema_with_super_metadata = StructType(fields)
    df_super = spark.createDataFrame(df_json_str.rdd, schema_with_super_metadata)
    return df_super


def flatten_json_df(_df: DataFrame) -> DataFrame:
    flattened_col_list = []

    def get_flattened_cols(df: DataFrame, struct_col: str = None) -> None:
        for col in df.columns:
            if df.schema[col].dataType.typeName() != 'struct':
                if struct_col is None:
                    flattened_col_list.append(f"{col} as {col.replace('.', '_')}")
                else:
                    t = struct_col + "." + col
                    flattened_col_list.append(f"{t} as {t.replace('.', '_')}")
            else:
                chained_col = struct_col + "." + col if struct_col is not None else col
                get_flattened_cols(df.select(col + ".*"), chained_col)

    get_flattened_cols(_df)
    return _df.selectExpr(flattened_col_list)

logger.info(jobRunId + " - zpes_glue_log - start ")
save_to_redshift = df \
    .writeStream \
    .outputMode("append") \
    .trigger(processingTime="{0} seconds".format(checkpointInterval)) \
    .foreachBatch(process_batch) \
    .option("checkpointLocation", checkpointLocation) \
    .option("windowSize", "10 seconds") \
    .option("batchMaxRetries", "3") \
    .start()

logger.info(jobRunId + " - zpes_glue_log - start awaitTermination")
save_to_redshift.awaitTermination()