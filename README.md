# Confluent Platform (cp-all-in-one)
- **Source:** https://github.com/confluentinc/cp-all-in-one

# Setup
- **Copy `.env.example` to `.env` & set env below**
    - AWS Access Key must have access `AmazonS3FullAccess`, `AWSGlueConsoleFullAccess`
```properties
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
```

- **Download JARs dependencies files for Flink-SQL-Client**
```bash
curl -f -o ./jars_flink_client/iceberg-flink-runtime-1.19-1.6.1.jar https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-flink-runtime-1.19/1.6.1/iceberg-flink-runtime-1.19-1.6.1.jar

curl -f -o ./jars_flink_client/hadoop-aws-3.3.4.jar https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.4/hadoop-aws-3.3.4.jar

curl -f -o ./jars_flink_client/bundle-2.17.260.jar https://repo1.maven.org/maven2/software/amazon/awssdk/bundle/2.17.260/bundle-2.17.260.jar

curl -f -o ./jars_flink_client/hadoop-common-3.3.4.jar https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-common/3.3.4/hadoop-common-3.3.4.jar

curl -f -o ./jars_flink_client/hadoop-hdfs-client-3.3.4.jar https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-hdfs-client/3.3.4/hadoop-hdfs-client-3.3.4.jar
```

- **Remove interceptor class**  
    - Do not set Confluent interceptor classes—these are not in the community image.
    - For `ksqldb-server`, set these in `docker-compose.yml`:
```yaml
KSQL_PRODUCER_INTERCEPTOR_CLASSES: ""
KSQL_CONSUMER_INTERCEPTOR_CLASSES: ""
```

- **Comment out to use default partition 12** due to Confluent-image bugs
```yaml
# CONTROL_CENTER_INTERNAL_TOPICS_PARTITIONS: 1
# CONTROL_CENTER_MONITORING_INTERCEPTOR_TOPIC_PARTITIONS: 1
```

- **Start all services with**
```sh
docker-compose up -d

# ----- OR ----- 

docker compose up -d broker
docker compose up -d schema-registry
docker compose up -d ksqldb-server
docker compose up -d rest-proxy
docker compose up -d ksqldb-cli
docker compose up -d prometheus
docker compose up -d alertmanager
docker compose up -d control-center
docker compose up -d flink-jobmanager
docker compose up -d flink-taskmanager
docker compose up -d flink-sql-client
```

# Access to Flink-SQL-Client
- **Run command below**
```shell
docker exec -it flink-sql-client sql-client.sh
```


