-- jar dependencies
ADD JAR '/opt/flink/lib/iceberg-aws-bundle-1.9.2.jar';
ADD JAR '/opt/flink/lib/iceberg-flink-runtime-1.19-1.9.2.jar';
ADD JAR '/opt/flink/lib/hadoop-aws-3.3.6.jar';
ADD JAR '/opt/flink/lib/hadoop-client-api-3.3.6.jar';
ADD JAR '/opt/flink/lib/hadoop-client-runtime-3.3.6.jar';