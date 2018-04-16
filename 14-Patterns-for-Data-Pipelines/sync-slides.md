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


## { data-background="images/pipeline-steel-thread-for-mobile-app.svg" } 

::: notes
review pipeline summary
:::


# 
## Full-Stack Streaming
::: notes
- last week we introduced Presto and Spark Streaming
:::


#
## Setup

## The `docker-compose.yml` 

Create a `docker-compose.yml` with the following
```
---
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
same as last week except `processingTime`
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

# 
## down

    docker-compose down

::: notes
:::



#
## summary

## { data-background="images/pipeline-steel-thread-for-mobile-app.svg" } 




#

<img class="logo" src="images/berkeley-school-of-information-logo.png"/>

