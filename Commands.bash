
*******************************************************
PRODUCER LAB
********************************************************

cd c:\kafka\kafka_2.13-2.5.0

1)RUN KAFKA BROKER
.\bin\windows\Zookeeper-server-start.bat .\config\zookeeper.properties

2)RUN KAFKA BROKER
  .\bin\windows\kafka-server-start.bat .\config\server.properties

3) CREATE KAFKA TOPIC
# CEATE A KAFKA TOPIC called first_kafka_topic

cd c:\kafka\kafka_2.13-2.5.0\bin\windows\

kafka-topics.bat --create --zookeeper localhost:2181 --replication-factor 1 --partitions 3 --topic from_producer_topic

4) LIST TOPICS
kafka-topics.bat --list --zookeeper localhost:2181

5) KAFKA CONSUMER
kafka-console-consumer.bat --bootstrap-server localhost:9090 --topic from_producer_topic --from-beginning



*******************************************************
CONSUMER LAB
********************************************************
1)RUN KAFKA BROKER
.\bin\windows\Zookeeper-server-start.bat .\config\zookeeper.properties

2)RUN KAFKA BROKER
  .\bin\windows\kafka-server-start.bat .\config\server.properties

3)CREATE TOPICS
kafka-topics.bat --create --zookeeper localhost:2181 --replication-factor 1 --partitions 3 --topic consumer-topic-01
kafka-topics.bat --create --zookeeper localhost:2181 --replication-factor 1 --partitions 3 --topic consumer-topic-02

4)DESCRIBE TOPICS
kafka-topics.bat --describe --topic consumer-topic-01 --zookeeper localhost:2181
kafka-topics.bat --describe --topic consumer-topic-02 --zookeeper localhost:2181

5)RUN PRODUCER PERF TEST
kafka-console-consumer.bat --bootstrap-server localhost:9090 --topic consumer-topic-01 --from-beginning

6)RUN CONSUMER
kafka-console-consumer.bat --bootstrap-server localhost:9090 --topic consumer-topic-01 --from-beginning

7)ALTER TOPIC PARTITION
kafka-topics.bat --zookeeper localhost:2181 --alter --topic consumer-topic-01 --partitions 4
