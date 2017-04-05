%MIDS w205 - Storing and Retrieving Data
%Fall 2017

<div class = "notes">Overall view of pipeline, basic query, all the way through in basic case (STIQ), all the way back through for streaming (ITSQ), wrap up whole pipeline</div>

# Introduction
pipeline patterns, basic queries

# Working with Data
datametadata, cli basics

# A Walk on the Query Side
first pass, athena, big query, caching, sql

# storing data
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

# more storing data
partioning II, Hadoop


# transforming data
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

# sourcing data

-pipeline for context (sourcing section)

when it's time to build the pipeline, where did the data come from?
	lineage 
	metadata - hits the road
	version
	schema

planning transformations based on in what state do you need the data to be in based on queryside
	full pass of tying it all together = query


# ingesting data
kafka aka messaging, cloud & containers

what kind of data are we talking about? - parallel of someone emails you data
our users are doing this... react to that... take action


latency - what is it
batch vs. real time
query driven
what breaks latency
glue
unix pipeline paradigm (kafka is like pipes in unix commands)


# transforming / streaming data
(Like no sql, no ETL - aka etl vs noetl) [not about transform but grab the piece of data you need]


modes of execution (B or S)
single event processing (storm)
microbatch (spark streaming)
batch (oozie, airflow, kron, sqoop etc)

understanding data - microbatch window is too small - introduction to sessionization & state


# in memory storing data
streaming & spark

dedicated stream processing -vs- shared architecture.  When is it time to give
stream processing its own resources?

distributed in-memory storage - alluxio and friends

distributed -vs- parallel... what's the deal?


# querying data
querying with partition keys

use the tools - `explain` and query profiling

take advantage of partitions when they're available

query planning for hive, impala, drill, presto, sparkSQL

use the tools - query planning


# querying data
streaming queries, caching vs stream queries

Caching and the web

A walk down memory lane - old-school data warehousing

Replay in an immutable pipeline

Caching queries


# querying data
understanding data - microbatch window is too small -  sessionization & state for action

understanding ingested events

understanding ingested events with lower latency

architectural patterns for taking action


# pipeline patterns revisited
some kind of project walkthrough - all screencast

