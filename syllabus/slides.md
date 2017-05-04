# Intro

## 01 - Introduction
 
Course intro, pipelines, events, and some basic queries.

    1.1 - Welcome
      1.1.1 - Context Problem [text page]
      1.1.2 - What is Data Engineering to you? [question]
      1.1.3 * What is Data Engineering? [lecture] [TM]
      1.1.4 - Why do I need Data Engineering for Data Science? [question]
      1.1.5 * What will I be able to do after this course? [lecture] [TM]

    1.2 - This Course
      1.2.1 * Organization and Approach [lecture]

    1.3 - Data Pipelines
      1.3.1 * What's a Data Pipeline? [lecture]
      1.3.2 * Typical Pipeline Components [lecture]
      1.3.3 - Explain briefly how Data Engineering is... [question]
      1.3.4 - Answer to prededing question [text page]

    1.4 - Events Everywhere
      1.4.1 - Take a moment to think about... [question]
      1.4.2 * Device Events [lecture] [TM]
      1.4.3 * User Events [lecture] [TM]
      1.4.4 * Event Streams [lecture] [TM]

    1.5 - Answer Questions about Data
      1.5.1 - Getting started with tools for queries [text page]
      1.5.2 - query on NYC Bike Data [context problem]


## 02 - Working with Data
 
Data, metadata, some basic tools.

    2.1 Working with Data
      2.1.1 - Brainstorm 3-5 ways you've received data... [question]
      2.1.2 * Introduction [lecture] [TM]
      2.1.3 - Formats
      2.1.4 - Schema/Types
      2.1.5 - Data Count / Range
      2.1.6 - Data Lineage
      2.1.7 - Data Access

    2.2 Tools for Working with Data
      2.2.1 - Introduction to Tools 
      2.2.2 - The Command Line [tutorial]
      2.2.3 - Jupyter Notebooks [tutorial]
      2.2.4 - Shells


## 03 - Welcome to the Queryside

Getting our feet wet with tools for querying data.

    3.1 What is the queryside?
      3.1.1 * Revisiting Pipelines [lecture]
      3.1.2 x Immutability [lecture]

    3.2 Query Tools
      3.2.1 - Queryside World 
      3.2.2 - SQL [Tutorial]
      3.2.3 - Athena
      3.2.4 - BigQuery

    3.3 Sneak Peek
      3.3.1 - Caching
      3.3.2 - Query Planning


# The Basics

## 04 - Storing Data

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

Encoding & Evolving

    4.1 Introduction
      4.1.1 * Where are we in the Pipeline? [lecture]

    4.2 Relational Data Stores
      4.2.1 * Relational Databases [lecture] [TM]
      4.2.2 * Relational DBs - Relations [lecture] [TM]
      4.2.3 * Relational DBs - Normalization [lecture] [TM]
      - SQL [question]

    4.3 NoSQL Data Stores
      4.3.1 * NoSQL Data Stores [lecture] [redo?]
      4.3.2 - NoSQL - Relational Model [activity]
      4.3.3 - NoSQL - Document Store [activity]
      4.3.4 - NoSQL - Key-Value Store [activity]
      - SQL -vs- NoSQL [question]

    4.4 Introduction to the Cloud
      4.4.1 - Virtuatlization and Containers
      4.4.2 - Infrastructure Encapsulation and Isolation
      4.4.3 - Using Containers
      - Virtual Machines and Containers [skype interview]
      - Cluster Computing
  

## 05 - Storing Data II
 
was "more storing data"
partioning II, Hadoop

    5.1 What is a Data Store?
      5.1.1 - What is a Data Store? [question]
      5.1.2 * Hadoop [lecture] [TM]
      - Hadoop Question [question]

    5.2 Distributed Computation
      - Distributed  
      - Distributed [question]
      5.2.3 x Failure in Distributed Systems [lecture]
      - Fault Tolerance [question]

    5.3 Hadoop
      - Hadoop Walkthrough
      - The Hadoop Ecosystem
        (upstream project webpages etc, with logos on pipeline)
      - Hadoop Ecosystem Question [question]


## 06 - Transforming Data
 
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
      6.1.1 * Transform Section of Pipeline [lecture]

    6.2 ETL
      - You don't always (aka usually) get what you want

    6.3 Hadoop ETL
      6.3.1 x Running Hadoop Jobs [lecture]
      - Hadoop ETL
      - ETL - traditional vs big data [question]

    6.4 Container Management
      6.4.1 - Working with YARN
      6.4.2 - Distributed Execution Models
      - Introduction to Schedulers
      - Schedulers Question [question]
      - Using a Scheduler



## 07 - Sourcing Data

-pipeline for context (sourcing section)

when it's time to build the pipeline, where did the data come from?
	lineage 
	metadata - hits the road
	version
	schema

	chain of evidence/custody

security / privacy / audits
    
    - remove pii
    - right to be forgotten
    - access control for pii data
    - audits
    - even part of move-fast agile approach
    - define levels of PII
    - tag datasets and jobs that relate to pii
    - enhanced logging/auditing for pii-related jobs
    - container-based security easier than 
      bolt-on-after-the-fact security for big data tools 

planning transformations based on in what state do you need the data to be in based on queryside
	full pass of tying it all together = query

    7.1 Pipeline Context
      7.1.1 * Pipeline Context [lecture]

    7.2 Where did the data come from?
      - APIs
      - Web scraping
      - Stuff gets emailed to you in .xlsx files
      - BI interfaces
      - Datastore (static vs dyanmic)

    7.3 What do you want to know about the data you get?
      - Context setting question [question]
      - Lineage
      - Metadata
      - Version
      - Schema
      - Tying it all together - Build a pipeline

    7.4 Security and Privacy
      7.4.1 x Security and Privacy [lecture]


## 08 - Querying Data
 

querying with partition keys

use the tools - `explain` and query profiling

take advantage of partitions when they're available

query planning for hive, impala, drill, presto, sparkSQL

use the tools - query planning


    8.1 Querying with Partition Keys
      8.1.1 * Pipeline Context [lecture]
      8.1.2 - Base decisions on queries 
      - Query Walthrough

    8.2 Tools
      - Tools
     
    8.3 Partitions
      8.3.1 - Querying with Partition Keys 
      - How to take advantage of partitions

    8.4 Query Planning
      - Planning Queries for Hive, Impala, and other tools
      - Using the Tools


# Streaming

## 09 - Ingesting Data
 
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
      9.1.1 * Where are we in the Pipeline? [lecture]

    9.2 Kafka
      9.2.1 * Distributed Messaging [lecture]
      - Kafka Walkthrough
      - Where are the data coming from?
      9.2.4 * Latency [lecture]
      - Batch vs. Real Time
      - Driven by Queries
      - Problems with Latency
      - Glue
 

## 10 - Transforming Streaming Data

was "transforming / streaming data"
(Like no sql, no ETL - aka etl vs noetl) [not about transform but grab the piece of data you need]


modes of execution (B or S)
single event processing (storm)
microbatch (spark streaming)
batch (oozie, airflow, kron, sqoop etc)

understanding data - microbatch window is too small - introduction to sessionization & state

architectural patterns for taking action


    10.1 NoETL
      10.1.1 * Pipeline Context [lecture]
      - Grabbing data you need as it streams by

    10.2 Modes of Execution
      - Batch -vs- Streaming
      - Single Event Processing
      - Microbatch
      - Handling Batch and Streaming Data in the Same System

    10.3
      - In Memory Computing
      - In Memory Computing [question]

    10.4 Take Action!
      10.4.1 x Take Action! [lecture]
      10.4.2 - Act! (pyspark watching kafka) [activity]


## 11 - Faster Data Stores

was "in memory storing data"
streaming & spark

dedicated stream processing -vs- shared architecture.  When is it time to give
stream processing its own resources?

distributed in-memory storage - alluxio and friends

distributed -vs- parallel... what's the deal?

    11.1 Pipeline Context
      11.1.1 * Pipeline Context [lecture]

    11.2 In Memory
      - Streaming and Spark
      - Structured Streaming

    11.3 Resource Selections
      - Dedicated Stream Processing?

    11.4 Distributed In-memory Storage
      - Distributed In-memory Storage

    11.5 Activity
      11.5.1 - Issues with Microbatch [question]
      11.5.2 - User Activity [lecture]
      11.5.3 - Defining User Activity [activity]



## 12 - Faster Queries
wanna change this to like "Streaming: Immediate Results"
"Streaming: Latency and Results"

structured streaming

streaming queries, caching vs stream queries

Caching and the web

datamarts, data warehouses, and data lakes, oh my!
A walk down memory lane - old-school data warehousing
and data mining

Replay in an immutable pipeline

ML integration points

Caching queries

    12.1 Queries
      - Caching -vs- Stream Queries
      - Caching and the Web
      - A walk down memory lane - data mining
      - Replay
      - Caching queries


# Putting it All Together

## 13 - Understanding Data

Understanding ingested events.

    13.1 Context
      13.1.1 * Pipeline Context [lecture]

    13.2 Sessionization and State
      13.2.1 * Sessionization and state for action [lecture]
      - Ingested Events
      - Low Latency Ingested Events
      - Architectural Patterns for Action

    13.3 Models
      - Model Validation
      - Model Management


## 14 - Patterns for Data Pipelines

Patterns and productionizing data pipelines.

    14.1 DevOps
      14.1.1 - Infrastructure as Code
      14.1.2 - Testing
      - CI/CD 
      - Logging and Monitoring
      - Automation
      - The Development Process

    14.2 Serverless Architectures
      14.2.1 - The Future of Data Engineering
      - AWS Kool-aid stack
      - GCP Kool-aid stack



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


