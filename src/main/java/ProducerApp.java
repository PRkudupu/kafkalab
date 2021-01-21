import org.apache.kafka.clients.producer.*;

import java.util.Properties;
import java.text.*;
import java.util.*;

public class ProducerApp {

    public static void main(String[] args){

        // Create the Properties class to instantiate the Consumer with the desired settings:
        Properties props = new Properties();
        props.put("bootstrap.servers", "localhost:9090, localhost:9093");
        props.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer");
        props.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer");

        KafkaProducer<String, String> myProducer = new KafkaProducer<String, String>(props);

        try {
            for (int i = 0; i < 150; i++ )
                myProducer.send(new ProducerRecord<String, String>("from_producer_topic", Integer.toString(i),"MyMessage: "+ Integer.toString(i)));
            // Thread.sleep(new Random(5000).nextLong()); // use if you want to randomize the time between record sends
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            myProducer.close();
        }

    }
}
