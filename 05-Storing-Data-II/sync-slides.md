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


# 
## Where are we in the pipeline?

![](images/pipeline-overall.svg)

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
## Docker-compose with Redis

::: notes
something about what we're going to do
:::

## Setup

## Create a workspace for this example

    mkdir ~/w205/redis
    cd ~/w205/redis


## Save the following to `docker-compose.yml` in that directory

    ---
    version: '2'
    services:
      redis:
        image: redis:latest
        expose:
          - "6379"
        extra_hosts:
          - "moby:127.0.0.1"

      mids:
        image: midsw205/base:latest
        stdin_open: true
        tty: true
        extra_hosts:
          - "moby:127.0.0.1"




## Spinup

- Start up the cluster

    docker-compose up -d


## Check stuff


    docker-compose ps

## Should see

             Name                        Command               State    Ports     
    ---------------------------------------------------------------------------
    redisexample_midsbase_1   /bin/bash                        Up      8888/tcp 
    redisexample_redis_1      docker-entrypoint.sh redis ...   Up      6379/tcp 


## Peek at the logs

    docker-compose logs redis

## Should see log output ending in

    Ready to accept connections


## Run stuff

- Connect to the mids container

    docker-compose exec mids bash

## At the prompt, run 

    ipython

## Try out redis

    import redis
    r = redis.Redis(host='redis', port='6379')
    r.keys()
    exit

## Exit that container

    exit

## Tear down your stack

    docker-compose down

## Verify 

    docker-compose ps

#
## Jupyter Notebooks


## Change the `docker-compose.yml` file 

    ---
    version: '2'
    services:
      redis:
        image: redis:latest
        expose:
          - "6379"
        extra_hosts:
          - "moby:127.0.0.1"

      mids:
        image: midsw205/base:latest
        stdin_open: true
        tty: true
        expose:
          - "8888"
        ports:
          - "8888:8888"
        extra_hosts:
          - "moby:127.0.0.1"

::: notes
- Add a port for the `mids` service
- Expose adds ports
- Ports exposes it out to the host
- Port is... channel for services to talk to each other.
:::

## Save that and bring it up

    docker-compose up -d

## Start up a notebook

    docker-compose exec mids jupyter notebook --no-browser --port 8888 --ip 0.0.0.0 --allow-root

## Copy token... should look something like

    open http://0.0.0.0:8888/?token=<your token>

## Open a browser

    http://0.0.0.0:8888

## Paste token

## Drop the cluster when you're done

    docker-compose down

#
## Automate notebook startup

Just for fun,

    ---
    version: '2'
    services:
      redis:
        image: redis:latest
        expose:
          - "6379"
        extra_hosts:
          - "moby:127.0.0.1"

      mids:
        image: midsw205/base:latest
        stdin_open: true
        tty: true
        expose:
          - "8888"
        extra_hosts:
          - "moby:127.0.0.1"
        command: jupyter notebook --no-browser --port 8888 --ip 0.0.0.0 --allow-root

## Test it out

    docker-compose up -d


## Run to get the token 

    docker-compose logs mids

## Open a browser

    open http://0.0.0.0:8888/?token=<your token>


## Open New Python3 Notebook

## Try redis


    import redis
    r = redis.Redis(host='redis', port='6379')
    r.keys()
    
## Add some values

    r.set('foo', 'bar')
    value = r.get('foo')
    print(value)

## Drop cluster

    docker-compose down


#
## Redis to track state

    ~/w205/redis

    curl -L -o trips.csv https://goo.gl/MVNVhW

::: notes
See nosql-kv-stores-video-hd1080-h264-30fps.mp4 
:::

## Spin up cluster

    docker-compose up -d


## Run to get the token 

    docker-compose logs mids

## Open a browser

    open http://0.0.0.0:8888/?token=<your token>


## Open New Python3 Notebook

## 

    import redis
    import pandas as pd

##

    trips=pd.read_csv('trips.csv')

    date_sorted_trips = trips.sort_values(by='end_date')

    date_sorted_trips.head()

##

    for trip in date_sorted_trips.itertuples():
      print(trip.end_date, '', trip.bike_number, '', trip.end_station_name)

::: notes
print date sorted list of where all bikes are
:::


##
    current_bike_locations = redis.Redis(host='redis', port='6379')
    current_bike_locations.keys()
    
## Add values

    for trip in date_sorted_trips.itertuples():
      current_bike_locations.set(trip.bike_number, trip.end_station_name)

##

    current_bike_locations.keys()

## Where is bike 92? 

    current_bike_locations.get('92')


## Drop cluster

    docker-compose down





## Summary

#
## 



::: notes
Using docker compose
Assembled a set of services
running a query within that
:::

#
## Extras
## Athena & AWS cli tool (aws) 

::: notes
if we need to fill time, do some queries wtih ebl data
:::


#

<img class="logo" src="images/berkeley-school-of-information-logo.png"/>

