---
title: Fundamentals of Data Engineering
author: Week 08 - sync session
...

---

#
## Assignment Review
- Review your Assignment 07
- Get ready to share

::: notes
Breakout at about 5 after the hour:
- Check in with each group 
- have students share screen
:::


## Due Friday (PR)

#
## 

![](images/streaming-bare.svg){style="border:0;box-shadow:none"}


::: notes
- Last week we  consume messages with Spark and take a look at them
- Now, we'll transform them in spark so we can land them in hdfs
:::

# 
## Spark Stack with Kafka and HDFS

## Setup

`mkdir ~/w205/spark-with-kafka-and-hdfs`

`cd ~/w205/spark-with-kafka-and-hdfs`

```
cp ~/w205/course-content//08-Querying-Data/docker-compose.yml .
```




## Spin up the cluster

```
docker-compose up -d
```
```
docker-compose logs -f kafka
```



::: notes
Now spin up the cluster
```
docker-compose up -d
```
and watch it come up
```
    docker-compose logs -f kafka
```
when this looks like it's done, you can safely detach with `Ctrl-C`.

:::


## Example: World Cup Players

## Check out Hadoop

```
docker-compose exec cloudera hadoop fs -ls /tmp/
```

## Should see something like:

	funwithflags:~/w205/spark-with-kafka-and-hdfs $ docker-compose exec cloudera hadoop fs -ls /tmp/
	Found 2 items
	drwxrwxrwt   - mapred mapred              0 2018-02-06 18:27 /tmp/hadoop-yarn
	drwx-wx-wx   - root   supergroup          0 2018-02-20 22:31 /tmp/hive

::: notes
Let's check out hdfs before we write anything to it
```
docker-compose exec cloudera hadoop fs -ls /tmp/
```
:::

## Create a topic `players`

```
docker-compose exec kafka \
  kafka-topics \
    --create \
    --topic players \
    --partitions 1 \
    --replication-factor 1 \
    --if-not-exists \
    --zookeeper zookeeper:32181
```

::: notes
First, create a topic `players`
```
docker-compose exec kafka kafka-topics --create --topic players --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:32181
```
:::

## Should show

    Created topic "players".

## Download the dataset for github players

- In `~/w205/`

```
curl -L -o players.json https://goo.gl/jSVrAe
```

## Use kafkacat to produce test messages to the `players` topic

```
docker-compose exec mids \
  bash -c "cat /w205/players.json \
    | jq '.[]' -c \
    | kafkacat -P -b kafka:29092 -t players"
```


::: notes
```
docker-compose exec mids bash -c "cat /w205/players.json | jq '.[]' -c | kafkacat -P -b kafka:29092 -t players"
```
:::


#
## Spin up a pyspark process using the `spark` container
```
docker-compose exec spark pyspark
```

::: notes
```
docker-compose exec spark pyspark
```

:::

## At the pyspark prompt, read from kafka

```
raw_players = spark \
  .read \
  .format("kafka") \
  .option("kafka.bootstrap.servers", "kafka:29092") \
  .option("subscribe","players") \
  .option("startingOffsets", "earliest") \
  .option("endingOffsets", "latest") \
  .load() 
```

::: notes
or, without the line-conitunations,
```
raw_players = spark.read.format("kafka").option("kafka.bootstrap.servers", "kafka:29092").option("subscribe","players").option("startingOffsets", "earliest").option("endingOffsets", "latest").load() 
```
:::


## Cache this to cut back on warnings later
```
raw_players.cache()
```

## See what we got
```
raw_players.printSchema()
```

## Cast it as strings (you can totally use `INT`s if you'd like)
```
players = raw_players.select(raw_players.value.cast('string'))
```

or
```
players = raw_players.selectExpr("CAST(value AS STRING)")
```

## Write this to hdfs
```
players.write.parquet("/tmp/players")
```


#
## Check out results (from another terminal window)

```
docker-compose exec cloudera hadoop fs -ls /tmp/
```

and
```

docker-compose exec cloudera hadoop fs -ls /tmp/players/
```

::: notes
You can see results in hadoop (from another terminal window)
```
docker-compose exec cloudera hadoop fs -ls /tmp/
```
and
```
docker-compose exec cloudera hadoop fs -ls /tmp/players/
```
:::

## However (back in spark terminal window)

- What did we actually write?

```
players.show()
```

::: notes
That's pretty ugly... let's extract the data, promote data cols to be
real dataframe columns.
:::

## Extract Data

## Deal with unicode 

```
import sys
sys.stdout = open(sys.stdout.fileno(), mode='w', encoding='utf8', buffering=1)
```

::: notes
If a dataset gripes about parsing `ascii` characters, you might need to default
to unicode... it's good practice in any case
:::


## What do we have?
- Take a look at

```
import json
players.rdd.map(lambda x: json.loads(x.value)).toDF().show()
```

##
```
extracted_players = players.rdd.map(lambda x: json.loads(x.value)).toDF()
```
```
from pyspark.sql import Row
extracted_players = players.rdd.map(lambda x: Row(**json.loads(x.value))).toDF()
```
```
extracted_players.show()
```
::: notes    
Note that this is deprecated.  It's easier to look at though.  The current
recommended approach to this is to explicitly create our `Row` objects
from the json fields
:::


## Save that
```
extracted_players.write.parquet("/tmp/extracted_players")
```

::: notes
which will be much easier to query.
NOTES: hmmm, we're switching contexts, but don't query this or do a docker-compose down

:::


#
## Example: GitHub Commits

## check out hadoop

Let's check out hdfs before we write anything to it

    docker-compose exec cloudera hadoop fs -ls /tmp/

## Create a topic

```
docker-compose exec kafka \
  kafka-topics \
    --create \
    --topic commits \
    --partitions 1 \
    --replication-factor 1 \
    --if-not-exists \
    --zookeeper zookeeper:32181
```

::: notes
First, create a topic `commits`
```
docker-compose exec kafka kafka-topics --create --topic commits --partitions 1 --replication-factor 1 --if-not-exists --zookeeper zookeeper:32181
```
- which should show

    Created topic "commits".
:::

## Download the dataset for github commits
```
curl -L -o github-example-large.json https://goo.gl/Hr6erG
```

## Publish some stuff to kafka

```
docker-compose exec mids \
  bash -c "cat /w205/github-example-large.json \
    | jq '.[]' -c \
    | kafkacat -P -b kafka:29092 -t commits"
```

::: notes
Use kafkacat to produce test messages to the `commits` topic

```
docker-compose exec mids bash -c "cat /w205/github-example-large.json | jq '.[]' -c | kafkacat -P -b kafka:29092 -t commits"
```
:::

## Spin up a pyspark process using the `spark` container
```
docker-compose exec spark pyspark
```

## Read stuff from kafka

- At the pyspark prompt, read from kafka

```
raw_commits = spark \
  .read \
  .format("kafka") \
  .option("kafka.bootstrap.servers", "kafka:29092") \
  .option("subscribe","commits") \
  .option("startingOffsets", "earliest") \
  .option("endingOffsets", "latest") \
  .load() 
```

::: notes
```
raw_commits = spark.read.format("kafka").option("kafka.bootstrap.servers", "kafka:29092").option("subscribe","commits").option("startingOffsets", "earliest").option("endingOffsets", "latest").load() 
```
:::

## Cache this to cut back on warnings
```
raw_commits.cache()
```

## See what we got
```
raw_commits.printSchema()
```

## Take the `value`s as strings
```
commits = raw_commits.select(raw_commits.value.cast('string'))
```

## Of course, we _could_ just write this to hdfs
```
commits.write.parquet("/tmp/commits")
```

- but let's extract the data a bit first...

## Extract more fields

- Let's extract our json fields again
```
extracted_commits = commits.rdd.map(lambda x: json.loads(x.value)).toDF()
```

## and see
```
extracted_commits.show()
```

## hmmm... did all of our stuff get extracted?
```
extracted_commits.printSchema()
```

- Problem: more nested json than before

::: notes
what's going on?
The problem is more nested json than before.
Here's a nice way to deal with that.
:::

## Use SparkSQL

- First, create a Spark "TempTable" (aka "View")
```
extracted_commits.registerTempTable('commits')
```

::: notes
We'll use `SparkSQL` to let us easily pick and choose the fields we want to
promote to columns.

Note that there are other ways to extract nested data, but `SparkSQL` is the
easiest way to see what's going on.
:::



## Then we can create DataFrames from queries
```
spark.sql("select commit.committer.name from commits limit 10").show()
```
```
spark.sql("select commit.committer.name, commit.committer.date, sha from commits limit 10").show()
```

## Grab what we want
```
some_commit_info = spark.sql("select commit.committer.name, commit.committer.date, sha from commits limit 10")
```

## Write to hdfs

- We can write that out
```
some_commit_info.write.parquet("/tmp/some_commit_info")
```

## Check out results

-You can see results in hadoop

```
docker-compose exec cloudera hadoop fs -ls /tmp/
```
and
```
docker-compose exec cloudera hadoop fs -ls /tmp/commits/
```

## Exit

- Remember, you can exit pyspark using either `ctrl-d` or `exit()`.


## Down
```
docker-compose down
```













































#
## Summary

## 

![](images/streaming-bare.svg){style="border:0;box-shadow:none"}


::: notes
- What did we do in this pipeline this week
:::

#

<img class="logo" src="images/berkeley-school-of-information-logo.png"/>

