%MIDS w205 - Storing and Retrieving Data
%Fall 2017

<div class = "notes">Overall view of pipeline, basic query, all the way through in basic case (STIQ), all the way back through for streaming (ITSQ), wrap up whole pipeline</div>

# Introduction
1
pipeline patterns, basic queries

1.1 Welcome to MIDS s205
  - Context Problem (text page)
  - What is Data Engineering to you? (question)
  - What is Data Engineering? (lecture)
  - Why do I need Data Engineering for Data Science? (lecture)
  - What will you know and be able to do after this course? (lecture)

1.2 Course Topics
  - Business or Technology? (lecture)
  - Sourcing and Ingesting Data (lecture)
  - Storing Data (lecture)
  - Transforming Data (lecture)
  - Querying Data (lecture)
  - Understanding and Acting on Data (lecture)
  - Visualizing and Communicating about Data (lecture)
  - Explain briefly how Data Engineering is... (question)
  - Answer to prededing question (text page)

1.3 Data Pipelines
  - Unpacking a data pipeline (lecture)
  - Patterns (lecture)

1.4 Events
  - Take a moment to think about... (question)
  - Device Events (lecture)
  - User Events (lecture)
  - Event Streams (lecture)

1.5 Querying
  - How to set up Google Big Query (text page)
  - Breaking down querying (lecture)
  - Requirements for taking action (lecture)
  - Walkthrough (context problem) query on NYC Bike Data


# Data Dive
2
was "Working with Data"

datametadata, cli basics

2.1 Working with Data
  - Brainstorm 3-5 ways you've received data... (question)
  - Introduction (lecture)
  - Schema/Types
  - Data Count
  - Data Ranges
  - Data Lineage
  - Data Access

2.2 Tools for Working with Data
  - Introduction to Tools (lecture)
  - The Command Line
  - Jupyter Notebooks
  - Shells
  - Wrap Up (lecture)


# Welcome to the Queryside
3
was "A Walk on the Query Side"

first pass, athena, big query, caching, sql

3.1 What is the queryside?
  - Revisiting Pipelines (lecture)
  - Immutability (lecture)
  - Event logs

3.2 Query Tools
  - Queryside World (lecture)
  - SQL
  - Athena
  - BigQuery

3.3 Sneak Peek
  - Caching (lecture)
  - Query Planning (lecture)
  - Resource Scheduling


# Storing Data
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
  - Where are we in the Pipeline? (lecture)

4.2 SQL vs NoSQL
  - Relational Data Stores (lecture)
  - NoSQL Data Stores (lecture)
  - NoSQL and Relational (question)

4.3 Introduction to the Cloud
  - Virtuatlization (lecture)
  - Virtual Machines vs Containers (skype interview)

4.4 Distributed and Parallel Computing
  - Distributed vs Parallel
  - Distributed vs Parallel (question)
  - In Memory Computing
  - In Memory Computing (question)
  - Cluster Computing
  - Fault Tolerance (lecture)
  - Fault Tolerance (question)
  
4.5 What is a Data Store?
  - Data Store in Pipeline (lecture)
  - Hadoop (lecture)
  - Hadoop and HDFS


# Storing Data II
5
was "more storing data"
partioning II, Hadoop


5.1 Partitioning
  - Partitioning (lecture)
  - Partitioning Live
  - Parittioning Question (question)

5.2 Hadoop
  - Hadoop and HDFS (lecture)
  - Hadoop Question (question)
  - The Hadoop Stack
  - HDFS Question (question)


# Transforming Data
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
  - Transform Section of Pipeline (lecture)

6.2 ETL
  - You don't always (aka usually) get what you want

6.3 Hadoop ETL
  - Revisiting Distributed Stores (lecture)
  - Hadoop ETL
  - ETL - traditional vs big data (question)

6.4 Container Management
  - Introduction to YARN (lecture)
  - Distributed Execution Models (lecture)
  - Introduction to Schedulers
  - Schedulers Question (question)
  - Using a Scheduler



# Sourcing Data
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
  - Pipeline Context (lecture)

7.2 Where did the data come from?
  - Context setting question (question)
  - Lineage (lecture)
  - Metadata
  - Version
  - Schema
  - Tying it all together - Build a pipeline

7.3 Planning Transformations
  - Base decisions on queries (lecture)
  - Query Walthrough
  - Transformations
  - Transformation Question (question)


# Ingesting Data
8
kafka aka messaging, cloud & containers

what kind of data are we talking about? - parallel of someone emails you data
our users are doing this... react to that... take action


latency - what is it
batch vs. real time
query driven
what breaks latency
glue
unix pipeline paradigm (kafka is like pipes in unix commands)


8.1 Pipeline Context
  - Where are we in the Pipeline? (lecture)

8.2 Kafka
  - Distributed Messaging (lecture)
  - Kafka Walkthrough
  - Where are the data coming from?
  - Latency (lecture)
  - Batch vs. Real Time
  - Driven by Queries
  - Problems with Latency
  - Glue

# Streaming: Transforming Data
9
was "transforming / streaming data"
(Like no sql, no ETL - aka etl vs noetl) [not about transform but grab the piece of data you need]


modes of execution (B or S)
single event processing (storm)
microbatch (spark streaming)
batch (oozie, airflow, kron, sqoop etc)

understanding data - microbatch window is too small - introduction to sessionization & state

9.1 NoETL
  - Pipeline Context (lecture)
  - Grabbing data you need as it streams by

9.2 Modes of Execution
  - Batch -vs- Streaming
  - Single Event Processing
  - Microbatch
  - Handling Batch and Streaming Data in the Same System

9.3 Sessionization and State
  - Sessionization and State (lecture)
  - Issues with Microbatch


# Streaming: Storing Data
10
was "in memory storing data"
streaming & spark

dedicated stream processing -vs- shared architecture.  When is it time to give
stream processing its own resources?

distributed in-memory storage - alluxio and friends

distributed -vs- parallel... what's the deal?

10.1 Pipeline Context
10.1.1 Pipeline Context (lecture)

10.2 In Memory
10.2.1 Streaming and Spark
10.2.2 Structured Streaming

10.3 Resource Selections
10.3.1 Dedicated Stream Processing?

10.4 Distributed In-memory Storage
10.4.1 Distributed In-memory Storage

10.5 Distributed vs. Parallel
10.5.1 Distributed vs. Parallel


# Querying Data
11

querying with partition keys

use the tools - `explain` and query profiling

take advantage of partitions when they're available

query planning for hive, impala, drill, presto, sparkSQL

use the tools - query planning

11.1 Querying with Partition Keys
11.1.1 Pipeline Context (lecture)

11.2 Tools
11.2.1 Tools
 
11.3 Partitions
11.3.1 Querying with Partition Keys (lecture)
11.3.2 How to take advantage of partitions

11.4 Query Planning
11.4.1 Planning Queries for Hive, Impala, and other tools
11.4.2 Using the Tools



# Querying Data II
12

streaming queries, caching vs stream queries

Caching and the web

datamarts, data warehouses, and data lakes, oh my!
A walk down memory lane - old-school data warehousing
and data mining

Replay in an immutable pipeline

Caching queries

12.1 Queries

12.1.1 Caching -vs- Stream Queries
12.1.2 Caching and the Web12.1 Queries
12.1.3 A walk down memory lane - data mining
12.1.4 Replay
12.1.5 Caching queries



# Querying Data III
13

understanding data - microbatch window is too small -  sessionization & state for action

understanding ingested events

understanding ingested events with lower latency

architectural patterns for taking action

## Sessionization and State
13.1

### Sessionization and state for action (lecture)
13.1.1

### Ingested Events
13.1.2

### Low Latency Ingested Events
13.1.3

### Architectural Patterns for Action
13.1.4



# Pipeline Patterns Revisited

some kind of project walkthrough - all screencast





---

# power clips

- cli
- notebooks
- programming (python)
- clouds and virtualization
- containers
- devops
- git and revision control
- serverless architectures
- web technologies ("Cache is King!")
- sql
- datamarts, data warehouses, and data lakes
- parallel -vs- distributed processing ("scientific programming")
