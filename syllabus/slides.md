%MIDS w205 - Storing and Retrieving Data
%Fall 2017

<div class = "notes">Overall view of pipeline, basic query, all the way through in basic case (STIQ), all the way back through for streaming (ITSQ), wrap up whole pipeline</div>

# 01 Introduction
1
pipeline patterns, basic queries

1.1 Welcome to MIDS s205
  - Context Problem [text page]
  - What is Data Engineering to you? [question]
  - What is Data Engineering? [lecture] [TM]
  - Why do I need Data Engineering for Data Science? [lecture]
  - What will you know and be able to do after this course? [lecture] [TM]

1.2 Course Topics
  - Business or Technology? [lecture]
  - Sourcing and Ingesting Data [lecture]
  - Storing Data [lecture]
  - Transforming Data [lecture]
  - Querying Data [lecture]
  - Understanding and Acting on Data [lecture]
  - Visualizing and Communicating about Data [lecture]
  - Explain briefly how Data Engineering is... [question]
  - Answer to prededing question [text page]

1.3 Data Pipelines
  - Unpacking a data pipeline [lecture]
  - Patterns [lecture]

1.4 Events
  - Take a moment to think about... [question]
  - Device Events [lecture] [TM]
  - User Events [lecture] [TM]
  - Event Streams [lecture] [TM]

1.5 Querying
  - How to set up Google Big Query [text page]
  - Breaking down querying [lecture]
  - Requirements for taking action [lecture]
  - Walkthrough [context problem] query on NYC Bike Data


# 02 Data Dive
2
was "Working with Data"

datametadata, cli basics

2.1 Working with Data
  - Brainstorm 3-5 ways you've received data... [question]
  - Introduction [lecture]
  - Schema/Types
  - Data Count
  - Data Ranges
  - Data Lineage
  - Data Access

2.2 Tools for Working with Data
  - Introduction to Tools [lecture]
  - The Command Line [tutorial]
  - Jupyter Notebooks [tutorial]
  - Shells
  - Wrap Up [lecture]


# 03 Welcome to the Queryside
3
was "A Walk on the Query Side"

first pass, athena, big query, caching, sql
google datalab

3.1 What is the queryside?
  - Revisiting Pipelines [lecture]
  - Immutability [lecture]
  - Event logs

3.2 Query Tools
  - Queryside World [lecture]
  - SQL
  - Athena
  - BigQuery

3.3 Sneak Peek
  - Caching [lecture]
  - Query Planning [lecture]
  - Resource Scheduling


Welcome to the modern datalab.

What do you need?

You need a safe platform to perform ad-hoc experimentation on data
The standard approach is that your experimentation will be productionized
over time and locked into a solid ETL pipeline.  We're moving away
from this approach and towards one that empowers the decision-makers
to do the experimentation directly.

How do do solve this?


# 04 Storing Data
-first pass, sql & nosql, partioning I, hadoop, cloud
quick discussion, point at pipeline, we're doing storage

distinction b/t sql and nosql

intro to cloud - first pass
    virtualization
    round table: VMs to containers
    cluster computing, non commodity hardware, 
    fault tolerant

distributed and parallel computing
in memory computing (1st pass)

blank slate about where data are from
what is a data store?
	introduce hadoop


4.1 Introduction
  - Where are we in the Pipeline? [lecture]

4.2 SQL vs NoSQL
  - Relational Data Stores [lecture] [TM]
  - NoSQL Data Stores [lecture]
  - NoSQL and Relational [question]

4.3 Introduction to the Cloud
  - Virtuatlization [lecture]
  - Containers - what are they [lecture]
  - Virtual Machines vs Containers [skype interview]
  - Cluster Computing
  

# 05 Storing Data II
5
was "more storing data"
partioning II, Hadoop

5.1 What is a Data Store?
  - Data Store in Pipeline [lecture]
  - Hadoop and HDFS [lecture] [TM]
  - Hadoop Question [question]

5.2 Distributed Computation
  - Distributed  
  - Distributed [question]
  - Fault Tolerance [lecture] [TM]
  - Fault Tolerance [question]

5.3 Partitioning
  - Partitioning [lecture]
  - Partitioning Live
  - Parittioning Question [question]

5.3 Hadoop
  - Hadoop Walkthrough
  - The Hadoop Ecosystem [screencast - go through e.g. Kafka project webpage etc, then put logos on pipeline]
  - Hadoop Ecosystem Question [question]


# 06 Transforming Data
6
first pass, etl & data munging, cloud, containers ()

-pipeline for context - transform section

you don't always get what you want (aka etl)
	you need to transform it
	not just where from / going, but how it's used
	

Hadoop
	distributed store
	hadoop etl (how analysis gets to the data)

cloud n containers - second pass (because how hadoop etl works requires schedulers)
  support distributed execution models
  intro to schedulers - how do you manage containers - spread the workload
  (YARN)


6.1 Introduction
  - Transform Section of Pipeline [lecture]

6.2 ETL
  - You don't always (aka usually) get what you want

6.3 Hadoop ETL
  - Revisiting Distributed Stores [lecture]
  - Hadoop ETL
  - ETL - traditional vs big data [question]

6.4 Container Management
  - Introduction to YARN [lecture]
  - Distributed Execution Models [lecture]
  - Introduction to Schedulers
  - Schedulers Question [question]
  - Using a Scheduler



# 07 Sourcing Data
7

-pipeline for context (sourcing section)

when it's time to build the pipeline, where did the data come from?
	lineage 
	metadata - hits the road
	version
	schema

planning transformations based on in what state do you need the data to be in based on queryside
	full pass of tying it all together = query

7.1 Pipeline Context
  - Pipeline Context [lecture]

7.2 Where did the data come from?
  - APIs
  - Web scraping
  - Stuff gets emailed to you in .xlsx files
  - BI interfaces
  - Datastore (static vs dyanmic)

7.3 What do you want to know about the data you get?
  - Context setting question [question]
  - Lineage [lecture]
  - Metadata
  - Version
  - Schema
  - Tying it all together - Build a pipeline

# 08 Querying I
8

querying with partition keys

use the tools - `explain` and query profiling

take advantage of partitions when they're available

query planning for hive, impala, drill, presto, sparkSQL

use the tools - query planning


8.1 Querying with Partition Keys
  - Pipeline Context [lecture]
  - Base decisions on queries [lecture]
  - Query Walthrough

8.2 Tools
  - Tools
 
8.3 Partitions
  - Querying with Partition Keys [lecture]
  - How to take advantage of partitions

8.4 Query Planning
  - Planning Queries for Hive, Impala, and other tools
  - Using the Tools


# 09 Streaming: Ingesting Data
9
kafka aka messaging, cloud & containers

what kind of data are we talking about? - parallel of someone emails you data
our users are doing this... react to that... take action


latency - what is it
batch vs. real time
query driven
what breaks latency
glue
unix pipeline paradigm (kafka is like pipes in unix commands)


9.1 Pipeline Context
  - Where are we in the Pipeline? [lecture]

9.2 Kafka
  - Distributed Messaging [lecture]
  - Kafka Walkthrough
  - Where are the data coming from?
  - Latency [lecture]
  - Batch vs. Real Time
  - Driven by Queries
  - Problems with Latency
  - Glue

# 10 Streaming: Transforming Data
10
was "transforming / streaming data"
(Like no sql, no ETL - aka etl vs noetl) [not about transform but grab the piece of data you need]


modes of execution (B or S)
single event processing (storm)
microbatch (spark streaming)
batch (oozie, airflow, kron, sqoop etc)

understanding data - microbatch window is too small - introduction to sessionization & state

10.1 NoETL
  - Pipeline Context [lecture]
  - Grabbing data you need as it streams by

10.2 Modes of Execution
  - Batch -vs- Streaming
  - Single Event Processing
  - Microbatch
  - Handling Batch and Streaming Data in the Same System

10.3
  - In Memory Computing
  - In Memory Computing [question]

10.3 Sessionization and State
  - Sessionization and State [lecture]
  - Issues with Microbatch


# 11 Streaming: Storing Data
11
was "in memory storing data"
streaming & spark

dedicated stream processing -vs- shared architecture.  When is it time to give
stream processing its own resources?

distributed in-memory storage - alluxio and friends

distributed -vs- parallel... what's the deal?

11.1 Pipeline Context
  - Pipeline Context [lecture]

11.2 In Memory
  - Streaming and Spark
  - Structured Streaming

11.3 Resource Selections
  - Dedicated Stream Processing?

11.4 Distributed In-memory Storage
  - Distributed In-memory Storage

11.5 Distributed vs. Parallel
  - Distributed vs. Parallel



# 12 Streaming: Querying Data 
12

structured streaming

streaming queries, caching vs stream queries

Caching and the web

datamarts, data warehouses, and data lakes, oh my!
A walk down memory lane - old-school data warehousing
and data mining

Replay in an immutable pipeline

Caching queries

12.1 Queries
  - Caching -vs- Stream Queries
  - Caching and the Web
  - A walk down memory lane - data mining
  - Replay
  - Caching queries


# 13 Understanding Data
13

understanding data - microbatch window is too small -  sessionization & state for action

understanding ingested events

understanding ingested events with lower latency

architectural patterns for taking action

13.1 Sessionization and State
  - Sessionization and state for action [lecture]
  - Ingested Events
  - Low Latency Ingested Events
  - Architectural Patterns for Action


# 14 Pipeline Patterns Revisited
14

some kind of project walkthrough - all screencast

14.1 DevOps
- infrastructure as code [lecture]
- testing [lecture]
- CI/CD 
- logging and monitoring
- automation
- walk through a development process

14.2 Serverless Architectures
[lecture - what Lak from google said]
- AWS Kool-aid stack
- GCP Kool-aid stack
- Tensorflow and the future of Data Engineering



---

# Tutorials

## The Command Line (in Week 1 or 2 of Synch Section)

- Just enough cli to manipulate data
- overcome command-line-anxiety


## Jupyter Notebooks (in Week 1 or 2 of Synch Section)

- Just enough python to work in a notebook
- Just enough python to manage datasets
- How to approach learning more python
- other languages



## Clouds and Virtualization (in Week 4 of Synch Section)

- What is the Cloud?
- what is a VM?
- How does DropBox et al work?

## Containers (in Week 4 of Synch Section)

- Docker FTW
- little bit of history
- docker on your laptop
- docker on your server
- docker in the cloud


## APIs and Web Services (in Week 7 of Synch Section)

- what's an API?

## Schedulers (in Week 6 of Synch Section)

- generic -vs- application-specific schedulers
- why do I care?
- execution context
- managing cluster load


## Revision Control using git (Prereq - TM get tutorial from Markham)

- intro to revision control
- text -vs- other formats
- working together
- first pass at CI/CD



## How the Web Works ("Cache is King!") (in Week 12 of Synch Section)

- useful to know this from a source ingestion perspective
- useful to know how cache works in general
- useful to see how this applies to pipeline concepts and query caches


## SQL (in Week 3 of Synch Section)

- Just enough sql to get by
- various flavors and extensions to sql
- Advanced sql
- Where to go for more?

check out Kleppmann's book for some decent examples for this


## Database Normalization (in Week 3 with rdb lecture)

- relational databases
- normalization
- oltp -vs- olap


## Datamarts, Data Warehouses, and Data Lakes (in Week 12 lecture on this stuff)

- usage
- necessary evil
- olap and star-shaped schema


## parallel -vs- distributed processing ("scientific programming")

- operator algebras... some linear algebra (no)
- diagonal, sparse, etc
- serial, vector, parallel compute models
- distributed computation
- gpus -vs- cpus


