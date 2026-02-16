import sys
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, explode, sum as spark_sum, round
from pyspark.sql.types import StructType, StructField, DoubleType, ArrayType
from awsglue.context import GlueContext
from awsglue.utils import getResolvedOptions
from awsglue.dynamicframe import DynamicFrame

# ==========================
# Spark & Glue Context
# ==========================
spark = SparkSession.builder.appName("weather_batch_job").getOrCreate()
glueContext = GlueContext(spark.sparkContext)

# ==========================
# Job Arguments
# ==========================
args = getResolvedOptions(sys.argv, [
    'JOB_NAME',
    'processed_bucket',
    'raw_bucket'
])

processed_bucket = args['processed_bucket']
raw_bucket = args['raw_bucket']

# ==========================
# Input path
# ==========================
input_path = f"s3://{raw_bucket}/weather/"

print(f"Reading from: {input_path}")

# ==========================
# Schema
# ==========================
schema = StructType([
    StructField("lat", DoubleType()),
    StructField("lon", DoubleType()),
    StructField("minutely", ArrayType(
        StructType([
            StructField("precipitation", DoubleType())
        ])
    ))
])

parsed_df = spark.read.schema(schema).json(input_path)

print("Loaded JSON with schema")

# ==========================
# Flatten minutely
# ==========================
flattened = parsed_df \
    .where(col("minutely").isNotNull()) \
    .select(
        col("lat"),
        col("lon"),
        explode(col("minutely")).alias("minute")
    )

print("Flattened minutely")

# ==========================
# Aggregate precipitation
# ==========================
aggregated = flattened.groupBy("lat", "lon").agg(
    round(spark_sum(col("minute.precipitation")), 2)
        .alias("total_precip_next_hour")
)

print("Aggregation complete")

aggregated.show()

# ==========================
# Write to DynamoDB
# ==========================
dynamic_df = DynamicFrame.fromDF(aggregated, glueContext, "dynamic_df")

glueContext.write_dynamic_frame.from_options(
    frame=dynamic_df,
    connection_type="dynamodb",
    connection_options={
        "dynamodb.region": "eu-west-1",
        "dynamodb.output.tableName": "weather-aggregated"
    }
)

print("Written to DynamoDB")
