---
title: Fundamentals of Data Engineering
author: Week 06 - sync session
...

---

- wrap up Assignment 5
- intro project 2, 
- demonstrate what is in the pipeline that's set up
- How to do project 2, part I assignment


## While we're getting started

- Review your Assignment 05
- Get ready to share

::: notes
Breakout at about 5 after the hour:
- Check in with each group 
- Choose 4-5 people with different approaches to present
- Usually takes 10-20 minutes
:::


## Groups present notebooks
::: notes
do nb and make recommendations
:::

## Due Friday (PR)


# 
## Where are we in the pipeline

##
![](images/pipeline-overall.svg){style="border:0;box-shadow:none"}

## Starting into Project 2
- Tracking User Activity

::: notes
- Will take a built pipeline,
- Manage data within it
- Using kafka, spark and hdfs
:::

##  Classes 6-8
- Class 6: Today will work with kafka to pull in messages
- Class 7: Start with simple spark
- Class 8: More complex spark, land data in hdfs


#
## Stand alone kafka

## Update your course content repo in w205

```
cd ~/w205/course-content
git pull --all
```

## Docker compose .yml file

- `cd w205`
- `mkdir kafka`
- save `docker-compose.yml` from recently pulled `~/w205/course-content` to
  recently created `~/w205/kafka` directory


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




## Docker compose spin things up

- `cd ~/w205/kafka`
- `docker-compose up -d`
- `docker-compose ps`

::: notes
- This is the start of spinning up things that will lead to projects 2&3
- Have them go through on command line, talk about what is happening.
:::

## Can check with

- `docker-compose ps`

## Should see something like

which should show something like

    Name                        Command            State   Ports
    -----------------------------------------------------------------------
    kafkasinglenode_kafka_1       /etc/confluent/docker/run   Up
    kafkasinglenode_zookeeper_1   /etc/confluent/docker/run   Up

## Check zookeeper

```
    docker-compose logs zookeeper | grep -i binding
```

## Should see something like

    zookeeper_1  | [2016-07-25 03:26:04,018] INFO binding to port 0.0.0.0/0.0.0.0:32181 (org.apache.zookeeper.server.NIOServerCnxnFactory)

## Check the kafka broker

```
    docker-compose logs kafka | grep -i started
```

## Should see something like

    kafka_1      | [2017-08-31 00:31:40,244] INFO [Socket Server on Broker 1], Started 1 acceptor threads (kafka.network.SocketServer)
    kafka_1      | [2017-08-31 00:31:40,426] INFO [Replica state machine on controller 1]: Started replica state machine with initial state -> Map() (kafka.controller.ReplicaStateMachine)
    kafka_1      | [2017-08-31 00:31:40,436] INFO [Partition state machine on Controller 1]: Started partition state machine with initial state -> Map() (kafka.controller.PartitionStateMachine)
    kafka_1      | [2017-08-31 00:31:40,540] INFO [Kafka Server 1], started (kafka.server.KafkaServer)


#
## Create a Topic `foo`

```
    docker-compose exec kafka kafka-topics --create --topic foo --partitions 1 --replication-factor 1 --if-not-exists --zookeeper localhost:32181
```


## Should see something like

    Created topic "foo".

## Check the topic

```
    docker-compose exec kafka kafka-topics --describe --topic foo --zookeeper localhost:32181
```

## Should see something like

    Topic:foo   PartitionCount:1    ReplicationFactor:1 Configs:
    Topic: foo  Partition: 0    Leader: 1    Replicas: 1  Isr: 1

#
## Publish Messages


    docker-compose exec kafka bash -c "seq 42 | kafka-console-producer --request-required-acks 1 --broker-list localhost:29092 --topic foo && echo 'Produced 42 messages.'"

::: notes
Use the kafka console producer to publish some test messages to that topic

:::

## Should see something like

    Produced 42 messages.


#
## Consume Messages

```
    docker-compose exec kafka kafka-console-consumer --bootstrap-server localhost:29092 --topic foo --from-beginning --max-messages 42
```

::: notes
Start a consumer to read from that topic
:::

## Should see something like

    1
    ....
    42
    Processed a total of 42 messages

::: notes
The consumer can be created before, during, or after the producer's run.
::: 

#
## Tearing things down

    docker-compose down

#
## Kafka with "real" messages

- We'll deal with json for the project

## Kafka with json example

## docker-compose.yml file


    ---
    version: '2'
    services:
      zookeeper:
        image: confluentinc/cp-zookeeper:latest
        environment:
          ZOOKEEPER_CLIENT_PORT: 32181
          ZOOKEEPER_TICK_TIME: 2000
        expose:
          - "2181"
          - "2888"
          - "32181"
          - "3888"
        #ports:
          #- "32181:32181"
        extra_hosts:
          - "moby:127.0.0.1"

      kafka:
        image: confluentinc/cp-kafka:latest
        depends_on:
          - zookeeper
        environment:
          KAFKA_BROKER_ID: 1
          KAFKA_ZOOKEEPER_CONNECT: zookeeper:32181
          KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://kafka:29092
          KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1
        volumes:
          - ~/w205:/w205
        expose:
          - "9092"
          - "29092"
        extra_hosts:
          - "moby:127.0.0.1"

      mids:
        image: midsw205/base:latest
        stdin_open: true
        tty: true
        volumes:
          - ~/w205:/w205
        extra_hosts:
          - "moby:127.0.0.1"

::: notes
Create a `docker-compose.yml` with the following
:::

## Pull data


    curl -L -o github-example-large.json https://goo.gl/WewtYn


## Spin up the cluster

    docker-compose up -d

## Watch it come up

    docker-compose logs -f kafka

- Detach with `Ctrl-C`


::: notes
when this looks like it's done, detach
:::

## use it

### create a topic

```

    docker-compose exec kafka kafka-topics --create --topic foo --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:32181
```

## Should see something like

    Created topic "foo".

## Check the topic

```
    docker-compose exec kafka kafka-topics --describe --topic foo --zookeeper zookeeper:32181
```

## Should see something like

    Topic:foo   PartitionCount:1    ReplicationFactor:1 Configs:
    Topic: foo  Partition: 0    Leader: 1    Replicas: 1  Isr: 1


#
## Publish some stuff to kafka

## Check out our messages

    docker-compose exec mids bash -c "cat /w205/github-example-large.json"
    docker-compose exec mids bash -c "cat /w205/github-example-large.json | jq '.'"
    docker-compose exec mids bash -c "cat /w205/github-example-large.json | jq '.[]' -c"



Check this section:
## Temporarily, install kafkacat (this is being baked into the mids image)

    docker-compose exec mids bash -c "apt-get -qq update && apt-get -yqq install kafkacat"

Use the kafka console producer to publish some test messages to that topic

    docker-compose exec mids bash -c "cat /w205/github-example-large.json | jq '.[]' -c | kafkacat -P -b kafka:29092 -t foo && echo 'Produced 100 messages.'"

## Should see something like

    Produced 100 messages.

#
## Consume the messages

## We can either do what we did before

```
    docker-compose exec kafka kafka-console-consumer --bootstrap-server kafka:29092 --topic foo --from-beginning --max-messages 42
```

## or 

```
    docker-compose exec mids bash -c "kafkacat -C -b kafka:29092 -t foo -o beginning -e"
```

## and maybe
```
    docker-compose exec mids bash -c "kafkacat -C -b kafka:29092 -t foo -o beginning -e" | wc -l
```

## Down

    docker-compose down


#
## Summary

## Template slide

- point
- point

::: notes
md works here
:::



#

<img class="logo" src="images/berkeley-school-of-information-logo.png"/>


#
## pipes

```
cat junk.csv | sort | uniq | wc -l
```

##
![](images/pipeline-overall.svg){style="border:0;box-shadow:none"}

#
## kafkacat

## 
![](images/kafkacat-syntax.svg){style="border:0;box-shadow:none"}

::: notes
omg, check out <https://explainshell.com/explain?cmd=tar%20xzvf%20archive.tar.gz>!
:::

#
## cool pics

## 
![](images/pipeline-ingestion-sourcing.svg){style="border:0;box-shadow:none"}

## 
![](images/queue-selected.svg){style="border:0;box-shadow:none"}

## 
![](images/pipeline-ingestion-sourcing-focus.svg){style="border:0;box-shadow:none"}

## 
![](images/pipeline-ingestion-from-files.svg){style="border:0;box-shadow:none"}

## 
![](images/streaming-bare.svg){style="border:0;box-shadow:none"}
