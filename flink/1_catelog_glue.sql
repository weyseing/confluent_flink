-- connector table
CREATE TABLE kafka_source_order (
  id INT,
  product STRING,
  amount INT,
  buyer_id INT,
  create_date STRING,
  update_date STRING,
  PRIMARY KEY (id) NOT ENFORCED
) WITH (
  'connector' = 'upsert-kafka',
  'topic' = 'stream_order_intake',
  'key.format' = 'json',
  'value.format' = 'json',
  'properties.bootstrap.servers' = 'broker:29092',
  'properties.group.id' = 'kafka_source_order'
);

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

-- sink table
CREATE TABLE IF NOT EXISTS iceberg_sink_order (
  `id` INT,
  `product` STRING,
  `amount` INT,
  `buyer_id` INT,
  `create_date` STRING,
  `update_date` STRING,
  PRIMARY KEY (`id`) NOT ENFORCED
) WITH (
  'format-version' = '2',
  'write.upsert.enabled' = 'true'
);

-- upsert job
SET 'execution.checkpointing.interval' = '10s';
SET 'execution.checkpointing.mode' = 'EXACTLY_ONCE';
INSERT INTO iceberg_sink_order
SELECT * FROM default_catalog.default_database.kafka_source_order;
