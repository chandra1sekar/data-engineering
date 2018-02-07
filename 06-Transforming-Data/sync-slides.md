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
- Check in with each group on their solution to the assignment
- Answer questions as people have them on what they had trouble with
- Usually takes 10-20 minutes
:::


## Groups present notebooks
::: notes
do nb and make recommendations
:::

## Due Friday (PR)


# 
## Where are we in the pipeline

![](images/pipeline-overall.svg)

#
## Docker compose

- What is docker compose?

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
## Summary

## Template slide

- point
- point

::: notes
md works here
:::



#

<img class="logo" src="images/berkeley-school-of-information-logo.png"/>

