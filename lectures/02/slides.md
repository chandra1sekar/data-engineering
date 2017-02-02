
---
title: "Working With Data"
date: MIDS - Fall 2017
...

---

# Why Do I Care?

- Data about data
- Tools

<div class="notes">
Let's talk about.. Data
</div>

# Data
##

##

- Format
- Schema
- Types
- Presence
- Count
- Ranges
- Integrity
- Lineage
- Versioning

<div class="notes">
data about data

some of the many dimensions of metadata

the list keeps going
- Durability
- Availability
- Access/Authorization
- Dependencies
- ...

and varies from dataset to dataset
</div>

#
## Format

- csv
- json
- avro
- ...

<div class="notes">
There're tons of file formats around

We'll go into more detail of lots of these formats later in the course

Focus for now on two common text-based formats: csv and json
</div>

#
## Schema

<div class="notes">
example using jq
</div>

#
## Types

<div class="notes">
example using jq
</div>

#
## Presence

<div class="notes">
example using jq and grep
</div>

#
## Data Count

<div class="notes">
example using jq, grep, and wc
</div>


#
## Data Ranges

<div class="notes">
example using jq, grep, uniq, and sort

how does this differ for really large datasets?
</div>


#
## Data Integrity

<div class="notes">
example using jq
</div>


#
## Data Lineage

<div class="notes">
what is the history of fields in this dataset?

dunno really what to show here
</div>


#
## Data Access

<div class="notes">
does it contain private data?

should access to this be restricted?

if so, how will users access this dataset?

dunno really what to show here
</div>




# Tools
##

##

- The Command Line
- Jupyter
- Excel
- IDEs
- Spark/Impala/Beeline/HBase/DB Shell
- REPLs
- Other Exploratory Environments

#
## The Command Line

<div class="notes">
surprise!  what we've been doing
</div>


#
## Jupyter

<div class="notes">
notebooks are great for data exploration

excellent way to take things to the next level

don't forget zeppelin!
</div>


#
## Shells

<div class="notes">
spark / pyspark
impala
beeline
hbase
etc

maybe even mention ipython here?
</div>


---

# scratch


# Why do I care?

## What Does a Data Scientist Actually Do?

<div class="notes">
There are lots of common misconceptions.

It's fun to walk through a few
</div>

##
![](images/what-i-do-machine-learning.jpg)

##
![](images/what-i-do-data-scientist-2.jpg)

##
![](images/what-i-do-data-scientist-1.jpg)

##
![](images/what-i-do-deep-learning.jpg)


# This Course
##

_Just enough_ data engineering to be effective as a data scientist

<div class="notes">
A survey of the domain of Data Engineering
</div>

## Organization

Based on data pipeline patterns

## { data-background="images/classifying-with-state.svg" }

<div class="notes">
We'll maintain context along the way using a common pipeline pattern
</div>

## Topics 

- Sourcing and Ingesting
- Storing
    - Encoding
    - Evolving
- Transforming
    - Batch Processing
    - Stream Processing
- Querying
    - Accessing
    - Languages and Tools
    - Planning
    - Optimizing
    - Productionalizing
- Understanding and Acting
    - Modeling
    - Analyzing
    - Tracking and Auditing
    - Monitoring
- Visualizing and Communicating


#
## Are our solutions:

- correct?
- tractable?
- stable?
- robust?
- reproducible?
- comprehensible?
- relevant?
- efficient?
- performant?

## Data Science

- correctness
- cardinality
- comparisons to external models
- invariants / symmetry
- intuition / geometry / wetware

## Engineering

- connectivity
- correctness
- performance

## Community

- pipeline patterns and tools
- failure modes
- sanity checks
- testing patterns in DS pipelines
- creative uses of simian army for data
- caching patterns in DS pipelines
- other places to steal ideas from?

