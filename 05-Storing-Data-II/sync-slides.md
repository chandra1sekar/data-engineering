---
title: Fundamentals of Data Engineering
author: Week 05 - sync session
...

---




#
## While we're getting started

- Review your Assignment 04
- Get ready to share

::: notes
Breakout at about 5 after the hour:
- Check in with each group on their solution to the assignment
- Answer questions as people have them on what they had trouble with
- Have 3-4 people present
:::



## Our solution??? Do we need this this week

## Due Friday (PR)

#
## Where are we?

## Today
- Assignment 04
- Run standalone kafka cluster
- NoSQL stores with docker compose

::: notes
- Watching RDBs and NoSQL videos b/t week 4 & week 5

- spin up 2 containers: redis & midsw205/base
- run python in one that's talking to redis in the other
- (docker compose + how to run a notebook in the container)
:::

## Between Class 5 & Class 6

- async material in Week 5 syllabus (Virtualization, Hadoop)
- Readings in Week 5 syllabus
- Assignment 05 (notebook to present)
- Final Assignment 04 due on Friday


## Class 6
- Final presentations of Query Project Notebooks/Recommendations 
- Tracking User Activity Project (spans Assignments 6-8)
- Prep activities for Assignment 06


#
## Standalone kafka cluster

## Update your course content repo in w205

`cd w205`
`cd course-content`
`git pull --all`

## Docker compose .yml file

- `cd w205`
- `mkdir kafka`
- save `docker-compose.yml` from recently pulled `~/w205/course-content` to recently created `~/w205/kafka` directory

::: notes

Save the following snippet as `~/w205/kafka/docker-compose.yml` on your host
filesystem

    ---
    version: '2'
    services:
      zookeeper:
        image: confluentinc/cp-zookeeper:latest
        network_mode: host
        environment:
          ZOOKEEPER_CLIENT_PORT: 32181
          ZOOKEEPER_TICK_TIME: 2000
        extra_hosts:
          - "moby:127.0.0.1"

      kafka:
        image: confluentinc/cp-kafka:latest
        network_mode: host
        depends_on:
          - zookeeper
        environment:
          KAFKA_BROKER_ID: 1
          KAFKA_ZOOKEEPER_CONNECT: localhost:32181
          KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://localhost:29092
          KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1
        extra_hosts:
          - "moby:127.0.0.1"

:::


## Run the cluster

    cd ~/w205/kafka
    docker-compose up -d


## Verify things started up ok

    docker-compose ps

## Should see something like

    Name                        Command            State   Ports
    -----------------------------------------------------------------------
    kafkasinglenode_kafka_1       /etc/confluent/docker/run   Up
    kafkasinglenode_zookeeper_1   /etc/confluent/docker/run   Up

## Check zookeeper

    docker-compose logs zookeeper | grep -i binding

## Should see something like

```
zookeeper_1  | \
[2016-07-25 03:26:04,018] \
INFO binding to port 0.0.0.0/0.0.0.0:32181 \
(org.apache.zookeeper.server.NIOServerCnxnFactory)
```

## Check the kafka broker

    docker-compose logs kafka | grep -i started

## Should see something like



    kafka_1      | [2017-08-31 00:31:40,244] INFO [Socket Server on Broker 1], Started 1 acceptor threads (kafka.network.SocketServer)
    kafka_1      | [2017-08-31 00:31:40,426] INFO [Replica state machine on controller 1]: Started replica state machine with initial state -> Map() (kafka.controller.ReplicaStateMachine)
    kafka_1      | [2017-08-31 00:31:40,436] INFO [Partition state machine on Controller 1]: Started partition state machine with initial state -> Map() (kafka.controller.PartitionStateMachine)
    kafka_1      | [2017-08-31 00:31:40,540] INFO [Kafka Server 1], started (kafka.server.KafkaServer)

::: notes
- Scroll on the slides that show screen results 
- We want it to look like what they'll see on their screens
:::

#
## Testing things out

## Create a Topic `foo`

```
    docker-compose exec \
    kafka kafka-topics --create --topic foo \
    --partitions 1 --replication-factor 1 \
    --if-not-exists --zookeeper \
    localhost:32181
```

::: notes
    docker-compose exec kafka kafka-topics --create --topic foo --partitions 1 --replication-factor 1 --if-not-exists --zookeeper localhost:32181
:::

## Should see something like


    Created topic "foo".

## Check the topic

```
    docker-compose exec \
    kafka kafka-topics --describe --topic foo \
    --zookeeper localhost:32181
```

::: notes

    docker-compose exec kafka kafka-topics --describe --topic foo --zookeeper localhost:32181
:::

## Should see something like

    Topic:foo   PartitionCount:1    ReplicationFactor:1 Configs:
    Topic: foo  Partition: 0    Leader: 1    Replicas: 1  Isr: 1

#
## Publish and Consume Messages

## Publish Messages

- Use the kafka console producer to publish some test messages to that topic

```
    docker-compose exec \
    kafka bash -c "seq 42 | kafka-console-producer \
    --request-required-acks 1 \
    --broker-list localhost:29092 \
    --topic foo && echo 'Produced 42 messages.'"
```

::: notes
    docker-compose exec kafka bash -c "seq 42 | kafka-console-producer --request-required-acks 1 --broker-list localhost:29092 --topic foo && echo 'Produced 42 messages.'"
:::

## Should see something like

    Produced 42 messages.


## Consume Messages

- Start a consumer to read from that topic
```
    docker-compose exec \
    kafka kafka-console-consumer \
    --bootstrap-server localhost:29092 \
    --topic foo --from-beginning --max-messages 42
```

::: notes
    docker-compose exec kafka kafka-console-consumer --bootstrap-server localhost:29092 --topic foo --from-beginning --max-messages 42
:::

## Should see something like

    1
    ....
    42
    Processed a total of 42 messages

- The consumer can be created before, during, or after the producer's run.

#
## Clean Up

## Tearing things down

    docker-compose down

#
## Jupyter Notebooks

##


```
docker run -it --rm -p 8888:8888 -v ~/w205:/w205 midsw205/base:latest
```


::: notes

docker run -it --rm -p 8888:8888 -v`pwd`:/tmartin midsw205/base:latest

jupyter notebook --no-browser --port 8888 --ip=0.0.0.0 --allow-root 


Regular container run
docker run -it --rm -v ~/w205:/w205 midsw205/base bash

:::

## Jupyter Notebook start up in container

```
jupyter notebook --no-browser --port 8888 --ip=0.0.0.0 --allow-root 
```

- get token
- `localhost:8888`

::: notes
run it in the container again (like I do on elias? on fwf?)
- what to do to get started
- some viz 

:::


## See slides
## Docker compose for redis container to work with w205midsbase

::: notes
docker compose file is in taylor@elias:~/w205/redis-state dir
redis with persistent volumes
w205
data in data store place
docker compose file
nb
docker compose up, down etc
docker compose exec inside the mids base container
install redis ahead

fix sleep part
fix pip install redis in midsbase
experiment with nohost networking
:::


## Redis activity

::: notes
import redis
import pandas

r=redis.Redis(host='localhost', port = 6379)

e.g. r.keys()

But see nosql-kv-stores-video-hd1080-h264-30fps.mp4 
:::

## Summary

#
## 



::: notes
md works here
:::

#
## Extras
## Athena & AWS cli tool (aws) 

::: notes
if we need to fill time, do some queries wtih ebl data
:::


#

<img class="logo" src="images/berkeley-school-of-information-logo.png"/>

