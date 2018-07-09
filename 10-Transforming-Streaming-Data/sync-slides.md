---
title: Fundamentals of Data Engineering
author: Week 10 - sync session
...

---

 

#
## Assignment Review
- Review your Assignment 09
- Get ready to share
- `docker pull midsw205/base:latest`
- `git pull` in `~/w205/course-content`

::: notes
- Seriously, took me about 5 min the other day

#### Breakout at about 5 after the hour:
- Check in with each group 
- have students share screen
:::


#
## { data-background="images/pipeline-simple-steel-thread.svg" } 

::: notes
What we need to have an end to end pipeline is:
- something up front generating events
- something to query out the back end
:::

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
## Project 3 options

- All: Essential game shopping cart data for homework
- Advanced option 1: Generate and filter more types of items
- Advanced option 2: Enhance the API to accept parameters for purchases (sword/item type)
- Advanced option 3: Shopping cart data & track state (e.g., user's inventory)


::: notes
- All: Game shopping cart data used for homework (flask app) 
- Advanced option 1: Generate (in flask) and filter (in spark) more types of items.
- Advanced option 2: Enhance the API (in flask) to accept parameters for purchases (sword/item type) and filter (in spark) 
- Advanced option 3: Shopping cart data & track state (e.g., user's inventory) and filter (in spark) 

:::


# 
## Flask with Kafka and Spark


## Set up directory, get docker-compose
```
mkdir ~/w205/flask-with-kafka-and-spark/
```
```
cd ~/w205/flask-with-kafka-and-spark/
```
```
cp ~/w205/course-content/10-Transforming-Streaming-Data/docker-compose.yml .
```

## The `docker-compose.yml` 

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

::: notes
- no need for a datafile on this one.
- Walk through the docker-compose.yml file
:::




## Spin up the cluster

```
docker-compose up -d
```

::: notes
:::


::: notes
Now spin up the cluster
```
docker-compose up -d
```
:::



## Create a topic

```
docker-compose exec kafka \
  kafka-topics \
    --create \
    --topic events \
    --partitions 1 \
    --replication-factor 1 \
    --if-not-exists --zookeeper zookeeper:32181
```


::: notes
- First, create a topic `events`
```
docker-compose exec kafka kafka-topics --create --topic events --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:32181
```
:::

## Should show

    Created topic "events".



# 
## Web-app


```python
#!/usr/bin/env python
from kafka import KafkaProducer
from flask import Flask
app = Flask(__name__)
producer = KafkaProducer(bootstrap_servers='kafka:29092')
topic = 'events'

@app.route("/")
def default_response():
    producer.send(topic, 'default'.encode())
    return "This is the default response!\n"

@app.route("/purchase_a_sword")
def purchase_a_sword():
    producer.send(topic, 'purchased_sword'.encode())
    return "Sword Purchased!\n"
```

::: notes
Take our instrumented web-app from before
:::


## More informative events


```python
#!/usr/bin/env python
import json
from kafka import KafkaProducer
from flask import Flask

app = Flask(__name__)
producer = KafkaProducer(bootstrap_servers='kafka:29092')


def log_to_kafka(topic, event):
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
let's get that to generate slightly more realistic events
:::

## Run it

```
docker-compose exec mids \
  env FLASK_APP=/w205/flask-with-kafka-and-spark/game_api_with_json_events.py \
  flask run --host 0.0.0.0
```

::: notes
```
docker-compose exec mids env FLASK_APP=/w205/flask-with-kafka-and-spark/game_api_with_json_events.py flask run --host 0.0.0.0
```
:::

## Test it by generating events

```
docker-compose exec mids curl http://localhost:5000/
```
```
docker-compose exec mids curl http://localhost:5000/purchase_a_sword
```

::: notes
- test it out by generating some events
```
docker-compose exec mids curl http://localhost:5000/
```
```
docker-compose exec mids curl http://localhost:5000/purchase_a_sword
```
- (repeat those a few times)
:::

## Read from kafka

```
docker-compose exec mids \
  kafkacat -C -b kafka:29092 -t events -o beginning -e
```


::: notes
and then reading them from kafka
```
docker-compose exec mids kafkacat -C -b kafka:29092 -t events -o beginning -e
```
:::

## Should show

```
{"event_type": "default"}
{"event_type": "default"}
{"event_type": "default"}
{"event_type": "purchase_sword"}
{"event_type": "purchase_sword"}
{"event_type": "purchase_sword"}
{"event_type": "purchase_sword"}
...
```

# 

## Add more events

- Let's add more stuff to the events we're sending.
- Will do this over 2 breakouts.

## Breakout 1 Discussion

- Discuss business requirements for the project
- Which fields should we include?

::: notes
- What are the kinds of events that I need to track as data scientist at the game company?
  * List events
  * Give business reasons for tracking them 
  * Groups report out
      * e.g., one event is "join a guild", what sort of business reason would you be tracking "join a guild"?
      * What other events other than the ones we're tracking now would you want to track?
:::


## Breakout 2 Discussion

- What info is available with these events?
- How should the events be structured?


::: notes
- 2nd breakout is the tech version - 
  * what flask request objects?
  * what info do they have?
  * what is the schema?
:::


# 

## Even _more_ informative events

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

## Run it
```
docker-compose exec mids \
  env FLASK_APP=/w205/flask-with-kafka-and-spark/game_api_with_extended_json_events.py \
  flask run --host 0.0.0.0
```

::: notes
```
docker-compose exec mids env FLASK_APP=/w205/flask-with-kafka-and-spark/game_api_with_extended_json_events.py flask run --host 0.0.0.0
```
:::

## Test it - generate events
```
docker-compose exec mids curl http://localhost:5000/
```
```    
docker-compose exec mids curl http://localhost:5000/purchase_a_sword
```

::: notes
```
    docker-compose exec mids curl http://localhost:5000/
    docker-compose exec mids curl http://localhost:5000/purchase_a_sword
```
:::

## Read from kafka
```
docker-compose exec mids \
  kafkacat -C -b kafka:29092 -t events -o beginning -e
```


::: notes
```
docker-compose exec mids kafkacat -C -b kafka:29092 -t events -o beginning -e
```
:::

## Should see 

```
{"Host": "localhost:5000", "event_type": "default", "Accept": "*/*", "User-Agent": "curl/7.47.0"}
{"Host": "localhost:5000", "event_type": "default", "Accept": "*/*", "User-Agent": "curl/7.47.0"}
{"Host": "localhost:5000", "event_type": "default", "Accept": "*/*", "User-Agent": "curl/7.47.0"}
{"Host": "localhost:5000", "event_type": "purchase_sword", "Accept": "*/*", "User-Agent": "curl/7.47.0"}
{"Host": "localhost:5000", "event_type": "purchase_sword", "Accept": "*/*", "User-Agent": "curl/7.47.0"}
{"Host": "localhost:5000", "event_type": "purchase_sword", "Accept": "*/*", "User-Agent": "curl/7.47.0"}
{"Host": "localhost:5000", "event_type": "purchase_sword", "Accept": "*/*", "User-Agent": "curl/7.47.0"}
...
```




# 
## Spark it up

## Run a spark shell
```
docker-compose exec spark pyspark
```

::: notes
check out `course-content/tutorials/tutorial-alternative-spark-clients.md` to
spin up the pyspark shell with `ipython` or `jupyter`!
:::

## Read from kafka

```
raw_events = spark \
  .read \
  .format("kafka") \
  .option("kafka.bootstrap.servers", "kafka:29092") \
  .option("subscribe","events") \
  .option("startingOffsets", "earliest") \
  .option("endingOffsets", "latest") \
  .load() 
```

::: notes
```
 raw_events = spark.read.format("kafka").option("kafka.bootstrap.servers", "kafka:29092").option("subscribe","events").option("startingOffsets", "earliest").option("endingOffsets", "latest").load() 
```
:::

## Explore our events
```
events = raw_events.select(raw_events.value.cast('string'))
```
```
extracted_events = events.rdd.map(lambda x: json.loads(x.value)).toDF()
```
```
extracted_events.show()
```    

::: notes
maybe turn on streaming?
(add the console appender as a sink)
`import json`
- Cache this to cut back on warnings
```
raw_events.cache()
```
:::

## down

    docker-compose down


















#

## Summary

## { data-background="images/pipeline-steel-thread-for-mobile-app.svg" } 

::: notes
(repeat from earlier)

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

<img class="logo" src="images/berkeley-school-of-information-logo.png"/>

