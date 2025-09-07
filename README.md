# Confluent Platform (cp-all-in-one)
- **Source:** https://github.com/confluentinc/cp-all-in-one

# Setup
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

# Access to KsqlDB via Ksql-CLI
To open an interactive ksqlDB CLI session connected to your ksqlDB server, run:
```sh
docker exec -it ksqldb-cli ksql --config-file /etc/ksqldb-cli.properties http://ksqldb-server:8088

docker exec -it ksqldb-cli ksql --config-file /etc/ksqldb-cli.properties http://ksqldb-server:8088 -e "SHOW STREAMS;"
```


