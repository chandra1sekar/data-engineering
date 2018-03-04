---
title: Fundamentals of Data Engineering
author: Week 09 - sync session
...

---

 

#
## Assignment Review
- Review your Assignment 08
- Get ready to share

::: notes
Breakout at about 5 after the hour:
- Check in with each group 
- have students share screen
:::


## Due Friday (PR)

#

## Project Transition


## { data-background="images/streaming-bare.svg" } 

## { data-background="images/streaming-bare-logos.jpg" } 

::: notes
- We walked through this pipeline
- Now going to move to new pipeline
:::

## Picture of new pipeline

::: notes
NOTE: need image
- What we need to have an end to end pipeline is something up front and something to query out the back end.
:::

## Project 3 Setup

- You're a data scientist at a game development company.  
- Your latest mobile game has two events you're interested in tracking: 
- `buy a sword` & `join guild`...
- Each has metadata

## Project 3 Task
- Your task: instrument your API server to catch and analyze these two
event types.

::: notes
options to decide before presenting to students:
- Using the containers provided -vs- freeform other containers
- mix these events on a single topic -vs- event-specific topics
- latency requirements of queries
- ?
- What data? For class activities -vs- homework, let's use health data: `patient check-in`
and `code blue`.
:::

## Project 3 options


::: notes
- All: Shopping cart data for homework
- Advanced option: Shopping cart data & track state
- Advanced option is not about getting more points, it's just if you want that challenge
:::

# 
## Flask with Kafka

## Setup

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

  mids:
    image: midsw205/base:latest
    stdin_open: true
    tty: true
    volumes:
      - ~/w205:/w205
    extra_hosts:
      - "moby:127.0.0.1"
```

::: notes
and with no need for a datafile on this one.
:::

## Spin up the cluster
```
docker-compose up -d
```

## Create a topic `events`
```
 docker-compose exec kafka \
   kafka-topics \
     --create \
     --topic events \
     --partitions 1 \
     --replication-factor 1 \
     --if-not-exists \
     --zookeeper zookeeper:32181
```

::: notes
```
 docker-compose exec kafka kafka-topics --create --topic events --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:32181
```
:::

## Should show

    Created topic "events".

#
## Let's create a web-based application

## An example scenario

- You're a mobile game developer.  During gameplay, your users perform various
actions such as

- purchase a sword
- purchase a knife
- join a guild
- etc

- To process these actions, your mobile app makes API calls to a web-based
API-server.  

## An API server - usual case

- User actions map to API endpoints
```
POST /purchase
```


::: notes
- User actions associated with purchases, for example, would generally map to
some generic API endpoint like

    POST /purchase

- that would also include a json payload describing the purchase... it'd list out
things like the quantity and items purchased.
- What is an api server?
- how do web addresses map to apis?
:::

## To keep it simple
- Our actions will map to single API calls

```
GET /purchase_a_sword
```

::: notes
- However, in order to keep things simple for now, we'll start with actions like
"purchase a sword" each corresponding to a single (hard-coded) API call such as

    GET /purchase_a_sword

- We'll use gets for everything though usually you'd do put or post
:::

## Flask

- Use the python `flask` library to write our simple API server.

```python
#!/usr/bin/env python3
from flask import Flask
app = Flask(__name__)

@app.route("/")
def default_response():
    return "This is the default response!"

@app.route("/purchase_a_sword")
def purchase-a-sword():
    return "Sword Purchased!"
```

::: notes
- Adding comments in functions
- Normal business logic if you e.g. purchase something, it would trigger put that thing in your inventory, charge you for whatever that would be etc. 
- But here, we're ...
- What is happening here (need visuals from API async materials)
- Introducing Python, Chapter 9, The Web Untangled is good for this
:::

##
- Save this as `~/w205/flask-with-kafka/game_api.py` and run it via
```
docker-compose exec mids pip3 install Flask
```
```
docker-compose exec mids env FLASK_APP=/w205/flask-with-kafka/game_api.py flask run
```

::: notes
- There are other ways to run the flask 
- Discuss what is its own container (service), pattern we've followed so far, how is this the same (mids is the container for flask here the same way it was for bash, kafkacat etc before)
:::

## Test it out 
```
docker-compose exec mids curl http://localhost:5000/
```
```
docker-compose exec mids curl http://localhost:5000/purchase_a_sword
```

::: notes
- Where are our data coming from this time
- Mobile app is hitting browser port 5000
- Mocking that up using curl locally
:::

## Stop flask
-Kill flask with `ctrl-c`.
::: notes
:::


## Generate events from our webapp

- Let's add kafka into the mix

```python
#!/usr/bin/env python3
from kafka import KafkaProducer
from flask import Flask
app = Flask(__name__)
producer = KafkaProducer(bootstrap_servers='kafka:29092')
topic = 'events'

@app.route("/")
def default_response():
    producer.send(topic, 'default'.encode())
    return "This is the default response!"

@app.route("/purchase_a_sword")
def purchase_a_sword():
    producer.send(topic, 'purchased_sword'.encode())
    return "Sword Purchased!"
```
::: notes
- We added one line per action in the api
- The act we're taking here is to log an event
- We're publishing to kafka because we want to implement for analytics
- Take that same python file and edit it to add these pieces 
:::

## Run that
```
docker-compose exec mids env FLASK_APP=/w205/flask-with-kafka/game_api.py flask run
```

::: notes
:::

## Test it out 
- Generate events
```
docker-compose exec mids curl http://localhost:5000/
```
```
docker-compose exec mids curl http://localhost:5000/purchase_a_sword
```

::: notes
:::

## Reading the events from kafka
```
docker-compose exec mids kafkacat -C -b kafka:29092 -t events -o beginning -e
```

::: notes
:::

##
## Notes

TBD:

- install flask into the base image

- set unicode locale..

    export LC_ALL=C.UTF-8
    export LANG=C.UTF-8

::: notes
:::


## read from kafka

- Use kafkacat to consume events from the `events` topic

```
docker-compose exec mids "kafkacat -C -b kafka:29092 -t events -o beginning -e"
```

::: notes
```
docker-compose exec mids "kafkacat -C -b kafka:29092 -t events -o beginning -e"
```
:::

## down

    docker-compose down

::: notes
:::


#

<img class="logo" src="images/berkeley-school-of-information-logo.png"/>

