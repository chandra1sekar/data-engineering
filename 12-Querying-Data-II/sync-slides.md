---
title: Fundamentals of Data Engineering
author: Week 12 - sync session
...

---


#
## Assignment Review
- Review your Assignment 10
- Get ready to share
- `docker pull midsw205/base:latest`
- `git pull` in `~/w205/course-content`

::: notes

#### Breakout at about 5 after the hour:
- Check in with each group 
- have students share screen
:::


## Due Friday (PR)

#


## { data-background="images/pipeline-steel-thread-for-mobile-app.svg" } 

::: notes
Let's walk through this
- user interacts with mobile app
- mobile app makes API calls to web services
- API server handles requests:
    - handles actual business requirements (e.g., process purchase)
    - logs events to kafka
- spark then:
    - pulls events from kafka
    - filters/flattens/transforms events
    - writes them to storage
- presto then queries those events
:::


# 
## Flask-Kafka-Spark-Hadoop-Presto Part I


#
## Setup

## Set up directory, get docker-compose
```
mkdir ~/w205/full-stack/
cd ~/w205/full-stack
cp ~/w205/course-content/12-Querying-Data-II/docker-compose.yml .
cp ~/w205/course-content/12-Querying-Data-II/*.py .
```

## The `docker-compose.yml` 

Create a `docker-compose.yml` with the following
```
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
    image: midsw205/cdh-minimal:latest
    expose:
      - "8020" # nn
      - "50070" # nn http
      - "8888" # hue
    #ports:
    #- "8888:8888"
    extra_hosts:
      - "moby:127.0.0.1"

  spark:
    image: midsw205/spark-python:0.0.5
    stdin_open: true
    tty: true
    volumes:
      - ~/w205:/w205
    expose:
      - "8888"
    ports:
      - "8888:8888"
    depends_on:
      - cloudera
    environment:
      HADOOP_NAMENODE: cloudera
    extra_hosts:
      - "moby:127.0.0.1"
    command: bash

  mids:
    image: midsw205/base:0.1.8
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

and with no need for a datafile on this one.

## Spin up the cluster

```
docker-compose up -d
```

::: notes
Now spin up the cluster
```
docker-compose up -d
```
:::


## Create a topic `events`

```
docker-compose exec kafka kafka-topics --create --topic events --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:32181
```


::: notes
First, create a topic `events`
```
docker-compose exec kafka kafka-topics --create --topic events --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:32181
```
which should show

    Created topic "events".
::: 

# 
## Web-app

- Take our instrumented web-app from before
`~/w205/full-stack/game_api.py`

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

## run flask
```
docker-compose exec mids \
  env FLASK_APP=/w205/full-stack/game_api.py \
  flask run --host 0.0.0.0
```

::: notes

```
docker-compose exec mids env FLASK_APP=/w205/full-stack/game_api.py flask run --host 0.0.0.0
```

:::

## Set up to watch kafka

```
docker-compose exec mids \
  kafkacat -C -b kafka:29092 -t events -o beginning
```


::: notes
- new terminal window, leave up

```
docker-compose exec mids kafkacat -C -b kafka:29092 -t events -o beginning
```
:::

## install apache bench

- Will be in `midsw205/base` later, but for now:
- install `ab`...

```
docker-compose exec mids \
  bash -c "apt-get update && apt-get install -y apache2-utils"
```

::: notes
```
docker-compose exec mids bash -c "apt-get update && apt-get install -y apache2-utils"
```

- For us later:
- install `ab` into the `midsw205/base` image
- and remove this section
:::

## generate some data

```
docker-compose exec mids ab -n 10 -H "Host: user1.comcast.com" http://localhost:5000/
```
```
docker-compose exec mids ab -n 10 -H "Host: user1.comcast.com" http://localhost:5000/purchase_a_sword
```
```
docker-compose exec mids ab -n 10 -H "Host: user2.att.com" http://localhost:5000/
```
```
docker-compose exec mids ab -n 10 -H "Host: user2.att.com" http://localhost:5000/purchase_a_sword
```

::: notes
- Choose to generate events with docker-compose exec or from browser window, but not both.
:::

# 
## More Spark

## last time
`~/w205/spark-from-files/separate_events.py`

```python
#!/usr/bin/env python
"""Extract events from kafka and write them to hdfs
"""
import json
from pyspark.sql import SparkSession, Row
from pyspark.sql.functions import udf


@udf('string')
def munge_event(event_as_json):
    event = json.loads(event_as_json)
    event['Host'] = "moe"
    event['Cache-Control'] = "no-cache"
    return json.dumps(event)


def main():
    """main
    """
    spark = SparkSession \
        .builder \
        .appName("ExtractEventsJob") \
        .getOrCreate()

    raw_events = spark \
        .read \
        .format("kafka") \
        .option("kafka.bootstrap.servers", "kafka:29092") \
        .option("subscribe", "events") \
        .option("startingOffsets", "earliest") \
        .option("endingOffsets", "latest") \
        .load()

    munged_events = raw_events \
        .select(raw_events.value.cast('string').alias('raw'),
                raw_events.timestamp.cast('string')) \
        .withColumn('munged', munge_event('raw'))

    extracted_events = munged_events \
        .rdd \
        .map(lambda r: Row(timestamp=r.timestamp, **json.loads(r.munged))) \
        .toDF()

    sword_purchases = extracted_events \
        .filter(extracted_events.event_type == 'purchase_sword')
    sword_purchases.show()
    # sword_purchases \
        # .write \
        # .mode("overwrite") \
        # .parquet("/tmp/sword_purchases")

    default_hits = extracted_events \
        .filter(extracted_events.event_type == 'default')
    default_hits.show()
    # default_hits \
        # .write \
        # .mode("overwrite") \
        # .parquet("/tmp/default_hits")


if __name__ == "__main__":
    main()
```

## which we ran

```
docker-compose exec spark spark-submit /w205/spark-from-files/separate_events.py
```

## what if different event types have different schema?

##
`~/w205/full-stack/just_filtering.py`

```python
#!/usr/bin/env python
"""Extract events from kafka and write them to hdfs
"""
import json
from pyspark.sql import SparkSession, Row
from pyspark.sql.functions import udf


@udf('boolean')
def is_purchase(event_as_json):
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
        .read \
        .format("kafka") \
        .option("kafka.bootstrap.servers", "kafka:29092") \
        .option("subscribe", "events") \
        .option("startingOffsets", "earliest") \
        .option("endingOffsets", "latest") \
        .load()

    purchase_events = raw_events \
        .select(raw_events.value.cast('string').alias('raw'),
                raw_events.timestamp.cast('string')) \
        .filter(is_purchase('raw'))

    extracted_purchase_events = purchase_events \
        .rdd \
        .map(lambda r: Row(timestamp=r.timestamp, **json.loads(r.raw))) \
        .toDF()
    extracted_purchase_events.printSchema()
    extracted_purchase_events.show()


if __name__ == "__main__":
    main()
```

::: notes
this is just one approach

what's another?
:::

## run this

```
docker-compose exec spark spark-submit /w205/full-stack/just_filtering.py
```

## we play with this

add a new event type to the flask app...

```python
@app.route("/purchase_a_knife")
def purchase_a_knife():
    purchase_knife_event = {'event_type': 'purchase_knife',
                            'description': 'very sharp knife'}
    log_to_kafka('events', purchase_knife_event)
    return "Knife Purchased!\n"
```


# 
## Write Events

##
`full-stack/filtered_writes.py`

```python
#!/usr/bin/env python
"""Extract events from kafka and write them to hdfs
"""
import json
from pyspark.sql import SparkSession, Row
from pyspark.sql.functions import udf


@udf('boolean')
def is_purchase(event_as_json):
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
        .read \
        .format("kafka") \
        .option("kafka.bootstrap.servers", "kafka:29092") \
        .option("subscribe", "events") \
        .option("startingOffsets", "earliest") \
        .option("endingOffsets", "latest") \
        .load()

    purchase_events = raw_events \
        .select(raw_events.value.cast('string').alias('raw'),
                raw_events.timestamp.cast('string')) \
        .filter(is_purchase('raw'))

    extracted_purchase_events = purchase_events \
        .rdd \
        .map(lambda r: Row(timestamp=r.timestamp, **json.loads(r.raw))) \
        .toDF()
    extracted_purchase_events.printSchema()
    extracted_purchase_events.show()

    extracted_purchase_events \
        .write \
        .mode('overwrite') \
        .parquet('/tmp/purchases')


if __name__ == "__main__":
    main()
```

## run this

```
docker-compose exec spark spark-submit /w205/full-stack/filtered_writes.py
```


## should see purchases in hdfs

```
docker-compose exec cloudera hadoop fs -ls /tmp/purchases/
```


# Queries From Spark

## spin up a notebook

```
docker-compose exec spark \
  env \
    PYSPARK_DRIVER_PYTHON=jupyter \
    PYSPARK_DRIVER_PYTHON_OPTS='notebook --no-browser --port 8888 --ip 0.0.0.0 --allow-root' \
  pyspark
```

::: notes
```
docker-compose exec spark env PYSPARK_DRIVER_PYTHON=jupyter PYSPARK_DRIVER_PYTHON_OPTS='notebook --no-browser --port 8888 --ip 0.0.0.0 --allow-root' pyspark
```
:::


## New python3 notebook and play

```
purchases = spark.read.parquet('/tmp/purchases')
purchases.show()
purchases.registerTempTable('purchases')
purchases_by_example2 = spark.sql("select * from purchases where Host = 'user2.att.com'")
purchases_by_example2.show()
newdf = purchases_by_example2.toPandas()
newdf.describe()
```


# 
## down

    docker-compose down


# 
## SecureShell (SSH)

#
## remote terminal connections

##

    ssh science@xxx.xxx.xxx.xxx

::: notes
for your cloud instance, look up:
- the ip address
- password for the `science` user
:::


#
## copying files

##

On your laptop, run

    scp some_file science@xxx.xxx.xxx.xxx:

or 

    scp some_file science@xxx.xxx.xxx.xxx:/tmp/


::: notes
copying files from your laptop to the instance

note the colon!
:::

##

On your laptop, run

    scp science@xxx.xxx.xxx.xxx:~/w205/a_file.py .


::: notes
copying files from the instance to your laptop

note the period!
:::


# 
## keys

::: notes
passwords suck... use keys
:::

## generate a keypair

    ssh-keygen -t rsa -b 2048

::: notes
hit return at all the prompts

windows users... use a bash shell please
:::

## this creates

a public key

    ~/.ssh/id_rsa.pub

and a secret key

    ~/.ssh/id_rsa

::: notes
public key safe to share/post
:::

## add pubkey to instance

From your laptop

    scp id_rsa.pub science@xxx.xxx.xxx.xxx:
    ssh science@xxx.xxx.xxx.xxx

then, on your cloud instance, run

    cat id_rsa.pub >> ~/.ssh/authorized_keys

## now no more passwords

    ssh science@xxx.xxx.xxx.xxx

::: notes
from your laptop
:::

## also add pubkey to github

::: notes
now no more passwords for git commands
:::



#
## Summary

- 


#

<img class="logo" src="images/berkeley-school-of-information-logo.png"/>

