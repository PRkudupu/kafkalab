
#############
##LAB 2
#############
cd C:\kafka\kafka_2.13-2.5.0\

1) Run zookeeper
.\bin\windows\Zookeeper-server-start.bat .\config\zookeeper.properties

2) Run Kafka Broker
  .\bin\windows\kafka-server-start.bat .\config\server.properties

cd C:\kafka\kafka_2.13-2.5.0\bin\windows

# START 3 BROKERS
3)
.\bin\windows\kafka-server-start.bat .\config\server-01.properties

.\bin\windows\kafka-server-start.bat .\config\server-02.properties

.\bin\windows\kafka-server-start.bat .\config\server-03.properties

# CREATE TOPIC WITH REPLICATION FACTOR AS 3

4) 
kafka-topics.bat --create --zookeeper localhost:2181 --replication-factor 3 --partitions 1 --topic replicated_3_topic

#look for the topic
5) 
kafka-topics.bat --describe --topic replicated_3_topic --zookeeper localhost:2181

#CREATE A PRODUCER
6)
kafka-console-producer.bat --broker-list localhost:9092 --topic replicated_3_topic

#CREATE A CONSUMER
7)
kafka-console-consumer.bat --bootstrap-server localhost:9092 --topic replicated_3_topic --from-beginning

#############
##LAB 3
#############
# CHANGE DIRECTORY
cd C:\kafka\kafka_2.13-2.5.0\
# RUN ZOOKEEPER
1) Run zookeeper
.\bin\windows\Zookeeper-server-start.bat .\config\zookeeper.properties

# RUN KAFKA BROKER
2) Run Kafka Broker
  .\bin\windows\kafka-server-start.bat .\config\server.properties
#CHANGE DIRECTORY
cd C:\kafka\kafka_2.13-2.5.0\bin\windows

#CREATE TOPIC
4) Create topics
kafka-topics.bat --create --zookeeper localhost:2181 --replication-factor 1 --partitions 3 --topic consumer-topic-01

kafka-topics.bat --create --zookeeper localhost:2181 --replication-factor 1 --partitions 3 --topic consumer-topic-02

#DESCRIBE TOPIC
4) Decribe topics
kafka-topics.bat --describe --topic consumer-topic-01 --zookeeper localhost:2181
kafka-topics.bat --describe --topic consumer-topic-02 --zookeeper localhost:2181

	
kafka-producer-perf-test.bat --topic consumer-topic-01 --num-records 50 --record-size 1 --throughput 10 --producer-props bootstrap.servers=localhost:9090 key.serializer=org.apache.kafka.common.serialization.StringSerializer value.serializer=org.apache.kafka.common.serialization.StringSerializer 
kafka-producer-perf-test.bat --topic consumer-topic-02 --num-records 50 --record-size 1 --throughput 10 --producer-props bootstrap.servers=localhost:9090 key.serializer=org.apache.kafka.common.serialization.StringSerializer value.serializer=org.apache.kafka.common.serialization.StringSerializer 

kafka-console-consumer.bat --bootstrap-server localhost:9090 --topic consumer-topic-01 --from-beginning
kafka-console-consumer.bat --bootstrap-server localhost:9090 --topic consumer-topic-02 --from-beginning




	 
	