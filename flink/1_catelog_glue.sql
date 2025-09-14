-- -- jar dependencies
-- ADD JAR '/opt/flink/lib/iceberg-aws-bundle-1.9.2.jar';
-- ADD JAR '/opt/flink/lib/iceberg-flink-runtime-1.19-1.9.2.jar';
-- ADD JAR '/opt/flink/lib/hadoop-aws-3.3.6.jar';
-- ADD JAR '/opt/flink/lib/hadoop-client-api-3.3.6.jar';
-- ADD JAR '/opt/flink/lib/hadoop-client-runtime-3.3.6.jar';

-- glue catalog
CREATE CATALOG catalog_glue WITH (
    'type'='iceberg',
    'catalog-impl'='org.apache.iceberg.aws.glue.GlueCatalog',
    'warehouse'='s3://kafka-iceberg-107698500998/',
    'io-impl'='org.apache.iceberg.aws.s3.S3FileIO'
);

USE CATALOG catalog_glue;
USE iceberg_db1;

SELECT * FROM `iceberg_db1`.`order` ORDER BY update_date DESC LIMIT 5;

