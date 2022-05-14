# **2022 ELS - MSK**

## Environment setup

1. Create a MSK cluster

* t2.small brokers * 3
* 10 GB for each brokers


2. Apply below parameters to the cluster
```
auto.create.topics.enable=true
default.replication.factor=3
min.insync.replicas=2
num.io.threads=8
num.network.threads=5
num.partitions=1
num.replica.fetchers=2
socket.request.max.bytes=104857600
unclean.leader.election.enable=true
```
3. Create a t2.micro EC2 as a kafka client
4. Install pip and kafka-python
```
curl -O https://bootstrap.pypa.io/pip/2.7/get-pip.py
pip install kafka-python
```
https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-install-linux.html



## Lab - 1

1. Run below code on your client machine. (Please replace the connection string to your own broker list)
```
import random
import json
from kafka import KafkaProducer
from kafka.errors import KafkaError

##Producer config

producer = KafkaProducer(bootstrap_servers='<BrokerList>'
        ,retries=5,retry_backoff_ms=6000,request_timeout_ms=60000
        ,value_serializer=lambda m: json.dumps(m).encode('ascii'))


for i in range(10000000):
    key=random.randint(0,99)
    value=random.randint(0,99)
    future=producer.send('msk-topic-1',{key:value},timestamp_ms=0)
    record_metadata = future.get(timeout=10)
    str = 'key:{0},value:{1},topic:{2},partition:{3},offset:{4}'.format(key,value,record_metadata.topic,record_metadata.partition,record_metadata.offset)
    print(str)
```
2. Running code for 3 minutes and stop it, then wait about 5 minutes and use console-consummer to consume data from beginning.
```
./kafka-console-consumer.sh --bootstrap-server <BrokerList> --topic msk-topic-1 --from-beginning
```


Questions:

1. What's your observation from console-conumer result?
2. Describe the possible reasons for your observation.
3. How to mitigate the issue from your observation?



## Lab - 2

1. Create the topic with below setting.
```
./kafka-topics.sh --create --bootstrap-server <BrokerList> --topic msk-topic-2 --partitions 6 --replication-factor 1
```

2. Run below code on your client machine. (Please replace the connection string to your own broker list)
```
import random
import json
from kafka import KafkaProducer
from kafka.errors import KafkaError

##Producer config

producer = KafkaProducer(bootstrap_servers='<BrokerList>'
        ,value_serializer=lambda m: json.dumps(m).encode('ascii')
        ,acks='all')


for i in range(10000000):
    key=random.randint(0,99)
    value=random.randint(0,99)
    future=producer.send('msk-topic-2',{key:value})
    record_metadata = future.get(timeout=10)
    str = 'key:{0},value:{1},topic:{2},partition:{3},offset:{4}'.format(key,value,record_metadata.topic,record_metadata.partition,record_metadata.offset)
    print(str)
```


Questions:

1. Which error messages you received from above code execution?
2. Describe the possible reasons from this issue.
3. How to mitigate the issue from your observation?



## Lab - 3

1. After mitigating the issue in Lab_2, please execute below command
```
./kafka-topics.sh --describe --topic <TopicName> --bootstrap-server <BrokerList>
```


2. Add one more broker per AZ through AWS MSK console

3. Describe the same topic again after the new broker has been added to the MSK cluster.
```
./kafka-topics.sh --describe --topic <TopicName> --bootstrap-server <BrokerList>
```


Questions:

1. Do you observe any partition been migrated to the new broker in step3? 
- If yes, why?
- If no, how to move the partitions to the new broker?


