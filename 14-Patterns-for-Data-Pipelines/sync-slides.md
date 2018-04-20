---
title: Fundamentals of Data Engineering
author: Week 14 - sync session
...

---

#
## Get Started
```
git pull in ~/w205/course-content
mkdir ~/w205/full-streaming-stack/
cd ~/w205/full-streaming-stack
cp ~/w205/course-content/14-Patterns-for-Data-Pipelines/docker-compose.yml .
docker-compose pull
cp ~/w205/course-content/14-Patterns-for-Data-Pipelines/*.py .

```

::: notes
:::



#
## Announcements

- droplets - copy all your stuff out by 27Apr2018
- repos - fork or clone your repos by 27Apr2018
- future - `course-content` tagged by semester

::: notes
- You'll maintain access to `mids-w205-<instructor>/course-content` 
- This semester will be tagged `spring2018`
- Explain will add read access for main course content (fund of data eng)
- Explain tagging
- Will have access to the version you had + updates for the future
:::

#
## { data-background="images/pipeline-steel-thread-for-mobile-app.svg" } 

::: notes
review pipeline summary
:::


# 
## Full-Stack Streaming
::: notes
- last week we introduced Presto and Spark Streaming
- Set up tmux session to have a pane for each service
:::


#
## Setup

## The `docker-compose.yml` 

Create a `docker-compose.yml` with the following
```yml
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
    expose:
      - "9092"
      - "29092"
    extra_hosts:
      - "moby:127.0.0.1"

  cloudera:
    image: midsw205/hadoop:0.0.2
    hostname: cloudera
    expose:
      - "8020" # nn
      - "8888" # hue
      - "9083" # hive thrift
      - "10000" # hive jdbc
      - "50070" # nn http
    ports:
      - "8888:8888"
    extra_hosts:
      - "moby:127.0.0.1"

  spark:
    image: midsw205/spark-python:0.0.6
    stdin_open: true
    tty: true
    volumes:
      - ~/w205:/w205
    expose:
      - "8888"
    ports:
      - "8889:8888" # 8888 conflicts with hue
    depends_on:
      - cloudera
    environment:
      HADOOP_NAMENODE: cloudera
      HIVE_THRIFTSERVER: cloudera:9083
    extra_hosts:
      - "moby:127.0.0.1"
    command: bash

  presto:
    image: midsw205/presto:0.0.1
    hostname: presto
    volumes:
      - ~/w205:/w205
    expose:
      - "8080"
    environment:
      HIVE_THRIFTSERVER: cloudera:9083
    extra_hosts:
      - "moby:127.0.0.1"

  mids:
    image: midsw205/base:0.1.9
    stdin_open: true
    tty: true
    volumes:
      - ~/w205:/w205
    expose:
      - "5000"
    ports:
      - "5000:5000"
    extra_hosts:
      - "moby:127.0.0.1"
```


::: notes
same as last week.. except for a port mapping to expose jupyter notebooks from the spark container
:::

## Spin up the cluster

```
docker-compose up -d
```

::: notes
- Now spin up the cluster
```
docker-compose up -d
```
- Notice we didn't actually create a topic as the broker does this for you
:::

## Web-app

- Take our instrumented web-app from before
`~/w205/full-streaming-stack/game_api.py`

```python
#!/usr/bin/env python
import json
from kafka import KafkaProducer
from flask import Flask, request

app = Flask(__name__)
producer = KafkaProducer(bootstrap_servers='kafka:29092')


def log_to_kafka(topic, event):
    event.update(request.headers)
    producer.send(topic, json.dumps(event).encode())


@app.route("/")
def default_response():
    default_event = {'event_type': 'default'}
    log_to_kafka('events', default_event)
    return "This is the default response!\n"


@app.route("/purchase_a_sword")
def purchase_a_sword():
    purchase_sword_event = {'event_type': 'purchase_sword'}
    log_to_kafka('events', purchase_sword_event)
    return "Sword Purchased!\n"
```

::: notes
- same web app as before
:::

## run flask
```
docker-compose exec mids \
  env FLASK_APP=/w205/full-streaming-stack/game_api.py \
  flask run --host 0.0.0.0
```

::: notes

```
docker-compose exec mids env FLASK_APP=/w205/full-streaming-stack/game_api.py flask run --host 0.0.0.0
```

:::

## Set up to watch kafka

```
docker-compose exec mids \
  kafkacat -C -b kafka:29092 -t events -o beginning
```


::: notes
- new terminal window, leave up
- running kafkacat without -e so it will run continuously
- run this twice so it'll create the topic

```
docker-compose exec mids kafkacat -C -b kafka:29092 -t events -o beginning
```
:::

# 
## Streaming

##

```python
#!/usr/bin/env python
"""Extract events from kafka and write them to hdfs
"""
import json
from pyspark.sql import SparkSession
from pyspark.sql.functions import udf, from_json
from pyspark.sql.types import StructType, StructField, StringType


def purchase_sword_event_schema():
    """
    root
    |-- Accept: string (nullable = true)
    |-- Host: string (nullable = true)
    |-- User-Agent: string (nullable = true)
    |-- event_type: string (nullable = true)
    """
    return StructType([
        StructField("Accept", StringType(), True),
        StructField("Host", StringType(), True),
        StructField("User-Agent", StringType(), True),
        StructField("event_type", StringType(), True),
    ])


@udf('boolean')
def is_sword_purchase(event_as_json):
    """udf for filtering events
    """
    event = json.loads(event_as_json)
    if event['event_type'] == 'purchase_sword':
        return True
    return False


def main():
    """main
    """
    spark = SparkSession \
        .builder \
        .appName("ExtractEventsJob") \
        .getOrCreate()

    raw_events = spark \
        .readStream \
        .format("kafka") \
        .option("kafka.bootstrap.servers", "kafka:29092") \
        .option("subscribe", "events") \
        .load()

    sword_purchases = raw_events \
        .filter(is_sword_purchase(raw_events.value.cast('string'))) \
        .select(raw_events.value.cast('string').alias('raw_event'),
                raw_events.timestamp.cast('string'),
                from_json(raw_events.value.cast('string'),
                          purchase_sword_event_schema()).alias('json')) \
        .select('raw_event', 'timestamp', 'json.*')

    sink = sword_purchases \
        .writeStream \
        .format("parquet") \
        .option("checkpointLocation", "/tmp/checkpoints_for_sword_purchases") \
        .option("path", "/tmp/sword_purchases") \
        .trigger(processingTime="120 seconds") \
        .start()

    sink.awaitTermination()


if __name__ == "__main__":
    main()
```

::: notes
- same as last week except `processingTime`
- Also 120 second window
:::


## Run it

```
docker-compose exec spark spark-submit /w205/full-streaming-stack/write_swords_stream.py
```

::: notes
wait a bit for the first stream interval to finish saving data
:::

## Check what it wrote to Hadoop

```
docker-compose exec cloudera hadoop fs -ls /tmp/sword_purchases
```

::: notes
:::

#
## Set up Presto

## Hive metastore

```
docker-compose exec cloudera hive
```


::: notes
- Run hive in the hadoop container
- This is what you would do, don't need to actually do it, skip to easier way
:::

## 

```sql
create external table if not exists default.sword_purchases (
    Accept string,
    Host string,
    User_Agent string,
    event_type string,
    timestamp string,
    raw_event string
  )
  stored as parquet 
  location '/tmp/sword_purchases'
  tblproperties ("parquet.compress"="SNAPPY");
```

::: notes
```
create external table if not exists default.sword_purchases (Accept string, Host string, User_Agent string, event_type string, timestamp string, raw_event string) stored as parquet location '/tmp/sword_purchases'  tblproperties ("parquet.compress"="SNAPPY");
```
and then `ctrl-D` to exit the hive shell

Note: you might browse the metastore in hue... `open http://localhost:8888/` (login/pw is `cloudera/cloudera`)

for droplets, `s/localhost/<droplet_ip>/`
:::

## Query this with presto

```
docker-compose exec presto presto --server presto:8080 --catalog hive --schema default
```

## What tables do we have in Presto?

```
presto:default> show tables;
```

## Describe `sword_purchases` table

```
presto:default> describe sword_purchases;
```

## Query `purchases` table

```
presto:default> select * from sword_purchases;
```


#
## Add some data

## Seed a little data into the stream

```
docker-compose exec mids \
  ab \
    -n 10 \
    -H "Host: user1.comcast.com" \
    http://localhost:5000/
```
```
docker-compose exec mids \
  ab \
    -n 10 \
    -H "Host: user1.comcast.com" \
    http://localhost:5000/purchase_a_sword
```
```
docker-compose exec mids \
  ab \
    -n 10 \
    -H "Host: user2.att.com" \
    http://localhost:5000/
```
```
docker-compose exec mids \
  ab \
    -n 10 \
    -H "Host: user2.att.com" \
    http://localhost:5000/purchase_a_sword
```

::: notes
- Will pump more events through once streaming is running

```
docker-compose exec mids ab -n 10 -H "Host: user1.comcast.com" http://localhost:5000/
docker-compose exec mids ab -n 10 -H "Host: user1.comcast.com" http://localhost:5000/purchase_a_sword
docker-compose exec mids ab -n 10 -H "Host: user2.att.com" http://localhost:5000/
docker-compose exec mids ab -n 10 -H "Host: user2.att.com" http://localhost:5000/purchase_a_sword
```
:::

## Query `purchases` table

```
presto:default> select * from sword_purchases;
```

::: notes
wait a stream cycle for data to be ingested
:::


#
## More data

## Feed the stream more data

```
while true; do
  docker-compose exec mids \
    ab -n 10 -H "Host: user1.comcast.com" \
      http://localhost:5000/purchase_a_sword
  sleep 10
done
```

::: notes
```
while true; do docker-compose exec mids ab -n 10 -H "Host: user1.comcast.com" http://localhost:5000/purchase_a_sword; sleep 10; done
```
:::

## Watch presto grow

```
presto:default> select count(*) from sword_purchases;
```

::: notes
remember, there's a two minute stream interval

Note: you might run hive directly from hue... `open http://localhost:8888/` (login/pw is `cloudera/cloudera`).
We recommend Presto as a much better query option in general, but hue has its uses.

for droplets, `s/localhost/<droplet_ip>/`
- hue can be used as a gui to browse the hdfs file directory, can upload and download files, change permissions, a lot of complications with hdfs are about permissions, so this easy access to what's up can be really helpful.
- That's why we've been writing to the tmp directory is to avoid dealing with permissions for this class.
- can also do a query editor in hue - e.g., select * from default.sword_purchases.
- hive will try to kick off a bunch of map reduce jobs under the hood, and we haven't set up the resources to handle that. 
- therefore, Presto is better.
:::


# 
## down

    docker-compose down

::: notes
:::


#
## { data-background="images/pipeline-steel-thread-for-mobile-app.svg" } 


#
## Building Docker Images

## Setup

```
mkdir -p ~/w205/docker/mytools
cd ~/w205/docker/mytools
```

::: notes
let's create a little workspace
:::

## The `Dockerfile`

Save this as `Dockerfile` in `~/w205/docker/mytools/`

```Dockerfile
FROM ubuntu:xenial
MAINTAINER Mark Mims <mark@digitalocean.com>

RUN apt-get -qq update \
  && apt-get -qq install -y jq apache2-utils
```

::: notes
rules to build docker images... we'll see more examples below
:::

## Build

```
docker build -t <tag> <path>
```

so, from a folder containing a `Dockerfile`,

```
docker build -t mytools .
```

::: notes
we've gone over `.` before, but reiterate

also, tag can include namespace and versions...
- `mytools` is implicitly `mytools:latest`
- `mytools:0.0.1` or `mytools:some-string-here`
- `markmims/mytools:0.0.1` or `midsw205/mytools:0.0.1`

- Need to tag mytools, fix permissions to do this
- `docker images | grep mytools`
:::

## check build ids and tags

```
docker images | grep mytools
```

## test a build

```
docker run -it --rm mytools bash
```

then at the prompt
```
which jq
```

::: notes
- show with `which jq` that the container we built is different than the ubuntu base container
`exit` or `ctl-d` to get out of the container after running this command
:::

## What did we do?

```
docker run -it --rm ubuntu:xenial which jq
docker run -it --rm mytools which jq
```

::: notes
bare `ubuntu` doesn't have `jq`, but ours does now
:::


## Iterate


## You can do more in a `Dockerfile`

```Dockerfile
FROM ubuntu:16.04
MAINTAINER Mark Mims <mark@digitalocean.com>

ENV SPARK_VERSION        2.2.0
ENV SPARK_HADOOP_VERSION 2.6

ENV SPARK_HOME /spark-$SPARK_VERSION-bin-hadoop$SPARK_HADOOP_VERSION
ENV JAVA_HOME  /usr/lib/jvm/java-8-oracle

ENV SPARK_TEMPLATE_PATH $SPARK_HOME/templates
ENV SPARK_CONF_PATH $SPARK_HOME/conf

ENV PATH $SPARK_HOME/bin:$PATH

RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
  && apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y software-properties-common \
  && add-apt-repository -y ppa:webupd8team/java \
  && apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF \
  && apt-get update \
  && apt-get install -y \
      curl \
      dnsutils \
      oracle-java8-installer \
  && apt-get purge -y software-properties-common \
  && apt-get autoremove -y \
  && curl -OL http://www-us.apache.org/dist/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop$SPARK_HADOOP_VERSION.tgz \
  && tar xf spark-$SPARK_VERSION-bin-hadoop$SPARK_HADOOP_VERSION.tgz \
  && rm spark-$SPARK_VERSION-bin-hadoop$SPARK_HADOOP_VERSION.tgz

COPY *-site.xml            $SPARK_TEMPLATE_PATH/
COPY *.properties          $SPARK_CONF_PATH/
COPY spark-defaults.conf   $SPARK_CONF_PATH
COPY spark-env.sh          $SPARK_CONF_PATH

COPY jars/* $SPARK_HOME/jars/

WORKDIR $SPARK_HOME

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["spark-shell"]
```

::: notes
- this is our `midsw205/spark-minimal` docker image

- note some of the primitives:
- `ENV`
- `RUN`
- `COPY`
- `CMD`

- show that it starts a spark shell (focus on `CMD` & `RUN`)

- Perhaps discuss chaining images.. i.e., use `FROM openjdk:8` instead of installing java the way we do here
:::


## Examples of different `Dockerfile`s

- [nginx](https://github.com/docker-library/nginx/blob/master/1.7/Dockerfile)
- [mongo](https://github.com/docker-library/mongo/blob/master/3.7/Dockerfile)
- [mysql](https://github.com/docker-library/mysql/blob/master/8.0/Dockerfile)
- [python](https://github.com/docker-library/python/blob/master/3.6/jessie/Dockerfile)
- [etc...](https://github.com/docker-library/)


::: notes
- Check out docker hub (hub.docker.com)
- search for e.g., mongo etc, see how many there are
- any big open source project is likely to have an image on docker hub
- also great place to see examples of Dockerfiles
- What is the process, you can keep images around - you only need to build once until you change it. 
- Then you spin up containers from them.
- (show could do RUN... then another RUN...) but that would be bloated. These files start wiht one image and they layer other file systems on top of it. Try to be efficient. Every RUN command is another file system layer. Trying to make each layer as minimal and efficient as possible.
- Our main image does not follow these guidelines :)
- Check out <https://docs.docker.com/compose/gettingstarted/> for a good example of integrating a container you _build_ into a cluster of containers.

:::


#

<img class="logo" src="images/berkeley-school-of-information-logo.png"/>

