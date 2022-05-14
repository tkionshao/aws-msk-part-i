--bootstrap-server b-1.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:9092,b-2.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:9092,b-3.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:9092
--zookeeper z-3.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:2181,z-1.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:2181,z-2.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:2181

# TOPIC:
# list
  ./k/kafka-topics.sh \
  --zookeeper z-3.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:2181,z-1.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:2181,z-2.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:2181 \
  --topic msk-topic-1 --list

# describe
  ./k/kafka-topics.sh \
  --zookeeper z-3.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:2181,z-1.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:2181,z-2.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:2181 \
  --describe \

  ./k/kafka-topics.sh \
  --zookeeper z-3.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:2181,z-1.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:2181,z-2.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:2181 \
  --topic msk-topic-2 --describe \

# delete topic
  ./k/kafka-topics.sh \
  --zookeeper z-3.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:2181,z-1.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:2181,z-2.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:2181 \
  --topic msk-topic-2 --delete
  --
# create topic
./k/kafka-topics.sh --create --bootstrap-server b-1.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:9092,b-2.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:9092,b-3.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:9092\
 --topic msk-topic-2 --partitions 6 --replication-factor 2

# alter topic
  TBD

# std producer
  ./k/kafka-console-producer.sh \
  --broker-list b-1.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:9092,b-2.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:9092,b-3.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:9092 \
  --topic msk-topic-1

# CONSUMER
# std comsumer, no specific consumer group.
  ./k/kafka-console-consumer.sh --bootstrap-server b-1.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:9092,b-2.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:9092,b-3.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:9092 \
  --topic msk-topic-1 
  --from-beginning

# create comsumer

bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test-topic --from-beginning --group my-created-consumer-group
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test-topic --from-beginning --consumer.config /path/to/config/consumer.properties

# check consumers
  ./k/kafka-consumer-groups.sh \
  --bootstrap-server b-1.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:9092,b-2.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:9092,b-3.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:9092 \
  --describe --all-groups
  
  --list

# deletion
  ./k/kafka-consumer-groups.sh \
  --bootstrap-server b-1.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:9092,b-2.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:9092,b-3.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:9092 \
   --delete --group lab01

# reset offset
  ./k/kafka-consumer-groups.sh \
  --bootstrap-server b-1.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:9092,b-2.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:9092,b-3.msklab.etjfp0.c2.kafka.ap-northeast-1.amazonaws.com:9092 \
  --topic msk-topic-1 --group lab1_02 --reset-offsets --to-offset 0 --execute























