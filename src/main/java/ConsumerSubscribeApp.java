import org.apache.kafka.common.*;
import org.apache.kafka.clients.consumer.*;

import java.util.*;

public class ConsumerSubscribeApp {
    public static void main(String[] args) {
        Properties props = new Properties();
        props.put("bootstrap.servers", "localhost:9090,localhost:9092");
        props.put("group.id", "0");
        props.put("enable.auto.commit", "true");
        props.put("auto.commit.interval.ms", "1000");
        props.put("session.timeout.ms", "30000");
        props.put("key.deserializer","org.apache.kafka.common.serialization.StringDeserializer");
        props.put("value.deserializer","org.apache.kafka.common.serialization.StringDeserializer");
        /// Create a KafkaConsumer instance and configure it with properties.
        KafkaConsumer myConsumer = new KafkaConsumer(props);

        // Create a topic subscription list:
        ArrayList<String> topics = new ArrayList<String>();
        topics.add("consumer-topic-01");
        topics.add("consumer-topic-02");
        // topics.add("myNewTopic");
        myConsumer.subscribe((topics));

        // Start polling for messages:
        try {
            while (true){
                ConsumerRecords<String,String> records = (ConsumerRecords<String, String>) myConsumer.poll(10000);
                for (ConsumerRecord<String, String> record : records) {
                    System.out.println(String.format("Topic: %s, Partition: %d, Offset: %d, Key: %s, Value: %s", record.topic(), record.partition(), record.offset(), record.key(), record.value()));
                }
            }
        } finally {
            myConsumer.close();
        }

    }



}
