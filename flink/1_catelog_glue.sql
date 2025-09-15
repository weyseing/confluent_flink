-- glue catalog
CREATE CATALOG catalog_glue WITH (
    'type'='iceberg',
    'catalog-impl'='org.apache.iceberg.aws.glue.GlueCatalog',
    'warehouse'='s3://kafka-iceberg-107698500998/',
    'io-impl'='org.apache.iceberg.aws.s3.S3FileIO'
);

-- preset
USE CATALOG catalog_glue;
USE iceberg_db1;

-- source table
CREATE TABLE kafka_source_order (
  `id` INT,
  `product` STRING,
  `amount` INT,
  `buyer_id` INT,
  `create_date` STRING,
  `update_date` STRING
) WITH (
  'connector' = 'kafka',
  'topic' = 'stream_order_intake',
  'properties.bootstrap.servers' = 'broker:29092',
  'properties.group.id' = 'flink-iceberg-consumer-20250915-1000',
  'format' = 'json', 
  'scan.startup.mode' = 'earliest-offset'
);

-- SET 'sql-client.execution.result-mode' = 'changelog';

-- CREATE TABLE test_topic_raw (
--   message STRING
-- ) WITH (
--   'connector' = 'kafka',
--   'topic' = 'test_topic',
--   'properties.bootstrap.servers' = 'broker:29092',
--   'properties.group.id' = 'flink_raw_debug',
--   'scan.startup.mode' = 'earliest-offset',
--   'format' = 'json'
-- );

-- CREATE TABLE test_topic_raw (
--   raw_value STRING
-- ) WITH (
--   'connector' = 'kafka',
--   'topic' = 'test_topic',
--   'properties.bootstrap.servers' = 'broker:29092',
--   'properties.group.id' = 'flink_raw_debug_20250915_1100',
--   'scan.startup.mode' = 'earliest-offset',
--   'format' = 'raw',
--   'raw.charset' = 'UTF-8'
-- );