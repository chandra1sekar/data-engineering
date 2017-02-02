
---
title: "Working With Data"
date: MIDS - Fall 2017
...

---

# Why Do I Care?
##

<div class="notes">
Let's talk about.. actual datasets
</div>

## 

"I emailed you the data... take a look and see what you think"

<div class="notes">
boss emails you some random csv file

or worse, xls
</div>

##

"I shared it in dropbox..."

<div class="notes">
coworker slacks you a dropbox or s3 bucket url

usually world readable
</div>

## 

"Have Julie get you access to the marketing database... just tell her I said it's ok"

<div class="notes">
boss blows you off
</div>

## 

"Just google around for an API that'll give you what you need for that analysis..."

<div class="notes">
coworker blows you off too
</div>

## 

..._Now_ What?


# Agenda

- Data about data
- Tools

<div class="notes">
This series will cover two things:

- practical metadata

- tools you can use to extract that metadata

Along the way, we'll get our feet wet in using the command line

Note that we'll gloss over some topics and allude to others here.
Don't worry, we'll cover _all_ of this material in a lot more
detail throughout the course.  This is meant to give you a feel
for the power of some of the tools involved.
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

the list keeps going...
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

## Format

[screencast exploring file formats from the command-line]

#
## Schema

[screencast on schema exploration from the command-line]

<div class="notes">
show screencast example using jq
</div>


#
## Types

[screencast on schema-types exploration from the command-line]

<div class="notes">
show screencast example using jq
</div>

#
## Presence

[screencast on content exploration from the command-line]

<div class="notes">
show screencast example using jq and grep
</div>

#
## Data Count

[screencast on counting content from the command-line]

<div class="notes">
show screencast example using jq, grep, and wc
</div>


#
## Data Ranges

[screencast on finding ranges of types from the command-line]

<div class="notes">
show screencast example using jq, grep, uniq, and sort

how does this differ for really large datasets?
</div>


#
## Data Integrity

[screencast on integrity from the command-line]

<div class="notes">
show screencast example using jq
</div>


#
## Data Lineage

[screencast on data lineage from the command-line]

<div class="notes">
what is the history of fields in this dataset?

dunno really what to show here
</div>


#
## Data Access

[screencast on accessing data from the command-line]

<div class="notes">
does it contain private data?

should access to this be restricted?

if so, how will users access this dataset?

this feeds directly into activity02
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


# Summary

- Data about data
- Tools

<div class="notes">
We covered two things:

- practical metadata

- tools you can use to extract that metadata

We saw some of the power of the command line in our examples
and associated activities.

Data exploration is really important, so we'll
revisit all of this material in greater detail
using various different tools throughout the course.
</div>

---

# scratch


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

