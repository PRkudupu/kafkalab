*******************************************************
REPLICA LAB
********************************************************
cd C:\kafka\kafka_2.13-2.5.0\

1) Run zookeeper
.\bin\windows\Zookeeper-server-start.bat .\config\zookeeper.properties

# CREATE 3 SERVER PROPERTIES FILEA AND START 3 BROKERS
2)Run 3 brokers
.\bin\windows\kafka-server-start.bat .\config\server-01.properties

.\bin\windows\kafka-server-start.bat .\config\server-02.properties

.\bin\windows\kafka-server-start.bat .\config\server-03.properties

cd C:\kafka\kafka_2.13-2.5.0\bin\windows
# CREATE TOPIC WITH REPLICATION FACTOR AS 3

4)
kafka-topics.bat --create --zookeeper localhost:2181 --replication-factor 3 --partitions 1 --topic replicated_3_topic

#look for the topic
5)
kafka-topics.bat --describe --topic replicated_3_topic --zookeeper localhost:2181


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
kafka-producer-perf-test.bat --topic consumer-topic-01 --num-records 50 --record-size 1 --throughput 10 --producer-props bootstrap.servers=localhost:9090 key.serializer=org.apache.kafka.common.serialization.StringSerializer value.serializer=org.apache.kafka.common.serialization.StringSerializer

6)RUN CONSUMER
kafka-console-consumer.bat --bootstrap-server localhost:9090 --topic consumer-topic-01 --from-beginning

7)ALTER TOPIC PARTITION
kafka-topics.bat --zookeeper localhost:2181 --alter --topic consumer-topic-01 --partitions 4
