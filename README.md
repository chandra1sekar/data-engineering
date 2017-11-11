# MIDS w205 - Fundamentals of Data Engineering 
### Mark Mims and Taylor Martin
### Spring 2018

## Course Description

Storing, managing, and processing datasets are foundational processes in data
science. This course introduces the fundamental knowledge and skills of data
engineering that are required to be effective as a data scientist. This course
focuses on the basics of data pipelines, data pipeline flows and associated
business use cases, and how organizations derive value from data and data
engineering.  As these fundamentals of data engineering are introduced,
learners will interact with data and data processes at various stages in the
pipeline, understand key data engineering tools and platforms, and use and
connect critical technologies through which one can construct storage and
processing architectures that underpin data science applications.

## Course Format

The course is organized as an online inverted classroom. During each week, students first
work through a set of asynchronous materials, including video lectures, readings, and other
activities. Once a week, students meet for a 90-minute live session, in which they connect with
an instructor and other students in an online classroom. A functioning webcam and an audio
headset are required to participate in the live sessions. Students must complete all assigned
asynchronous material before the scheduled live session begins.

## Course Objectives

### Tools and Technologies
Students will:
- Build practical experience building data pipelines.
- Build practical experience cleaning, anonymizing, and plumbing data.
- Learn tooling for queries and query management (e.g., BigQuery, SQL).
- Learn tooling for analytics (jupyter, python, py-based-libs).
- Get exposure to advanced tooling for analytics (spark, kafka, etc).
- Learn how to leverage revision control.
- Learn how to use docker to assemble common tools for analysis.
- Build practical experience leveraging cloud-based resources for data analytics.
- Build practical experience consuming data and services from APIs.
- Get exposure to events and event-log based analytics.

### Concepts
Students will:
- Learn to keep their analysis grounded in busines relevence.
- Get exposure to some basic distributed storage and compute concepts.
- Get exposure to some basic RDBMS concepts.
- Get exposre to RDB -vs- NoSQL tooling and approaches.
- Get exposure to some basic data warehousing concepts.
- Learn the basics of virtualization and containerization.
- Understand how analysis changes wrt scale / complexity of data.
- Learn about data partitioning.
- Learn about latency in data analysis.
- Get exposure to ETL -vs- NoETL.
- Learn the basic concepts of web-based applications.
- Understand how basic data privacy, security, and chain-of-custody works.


## Evaluation & Grading
- There are 10 assignments, each of which is 10% of your grade.

## Prerequisites:
-Previous experience with Python.
-Basic knowledge of Unix/Linux commands and tools as well as concepts such as processes, file systems.

## Course Outline
The course consists of 4 sections: A 3-week Introduction that covers the basics of storage and retrieval concepts and tools; a 5-week Basics section that provides a deeper exploration of working with data and data pipelines; a 4-week section that focuses on Streaming Data; and a concluding section, Putting it All Together, that integrates concepts and skills from the entire course into a cohesive model of the data pipeline. 

In addition to the sequenced material covered, the course also includes Tutorial materials that focus on technical skills associated with data engineering technologies, tools, and platforms. These tutorials also provide a practical foundation for the discussions and activities that will take place in the live classroom for specific weeks in the term.

# Introduction
## Week 01 - Introduction

#### Themes: What is Data Engineering? Gathering event data. Get started with queries.

#### Readings:

Data Science vs. Data Engineering/cr 
Insight Data Science blog 
https://blog.insightdatascience.com/data-science-vs-data-engineering-62da7678adaa

Network Programmability and Automation 
by Jason Edelman, Matt Oswalt, Scott S. Lowe
Chapter 8. Source Control with Git

Analytics For Hackers: How To Think About Event Data
by Michelle Wetzler

#### Assignment 01: Set up and prerequisites



## Week 02 - Working with Data

#### Themes: Intro to data, metadata, and some basic tools for working with data.

#### Readings:

Network Programmability and Automation
by Jason Edelman, Matt Oswalt, Scott S. Lowe
Chapter 5. Data Formats and Data Models

Python for Data Analysis, 2nd Edition
by William Wesley McKinney
Chapter 2.2 IPython Basics
 
#### Assignment 02: Querying data with BigQuery


## Week 03 - Welcome to the Queryside

#### Themes: 

#### Readings:

Designing Data-Intensive Applications, 1st Edition
Martin Kleppmann
Chapter 2. Data Models and Query Languages

Learning SQL, 2nd Edition
by Alan Beaulieu
Chapter 3. Query Primer


#### Assignment 03: Querying data from the command line



# The Basics

## Week 04 - Storing Data

#### Themes: Relational and NoSQL datastores, introduction to cloud concepts

#### Readings:
Using Docker
by Adrian Mouat
Chapter 1. The What and Why of Containers

Infrastructure as Code
by Kief Morris
Chapter 1. Challenges and Principles

Modern Linux Administration
by Sam R. Alapati
Chapter 1. Modern Linux System Administration


## Week 05 - Storing Data II

#### Themes: Distributed Computation and Hadoop

#### Readings:
Hadoop: The Definitive Guide, 4th Edition
by Tom White
Chapters 1-3

#### Assignment 04 - Employ notebooks to synthesize query project results (Query Project)



## Week 06 - Transforming Data

#### Themes: ETL and its discontents, more Hadoop, and container management

#### Readings:
Designing Data-Intensive Applications, 1st Edition
Martin Kleppmann
Chapter 10. Batch Processing

Designing Data-Intensive Applications, 1st Edition
Martin Kleppmann
Chapter 11. Stream Processing

Hadoop: The Definitive Guide, 4th Edition
by Tom White
Chapter 4. YARN



## Week 07 - Sourcing Data

#### Themes: Data and its provenance, security and privacy

#### Readings:
Modern Linux Administration
by Sam R. Alapati
Chapter 15. Security and Compliance in the Modern Systems Environment

#### Assignment 05 - Get and clean data (Deep Learning Project)


## Week 08 - Querying Data

#### Themes: Querying with partition keys and query planning

#### Readings:
Designing Data-Intensive Applications, 1st Edition
by Martin Kleppmann
Chapter 6. Partitioning


# Streaming

## Week 09 - Ingesting Data

#### Themes: Ingesting streaming data, using Kafka, considerations of latency.

#### Readings:
Kafka: The Definitive Guide, 1st Edition
by Gwen Shapira, Neha Narkhede, Todd Palino
Chapter 7. Building Data Pipelines
 
#### Assignment 06 - Set up pipeline (Deep Learning Project)



## Week 10 - Transforming Streaming Data

#### Themes: NoETL, batch vs streaming, in-memory computing.

#### Readings:
High Performance Spark, 1st Edition
by Holden Karau, Rachel Warren
Chapter 2. How Spark Works

Learning Spark
by Andy Konwinski, Holden Karau, Matei Zaharia, Patrick Wendell
Chapter 10. Spark Streaming

#### Assignment 07 - Train model and test on new data (Deep Learning Project)



## Week 11 - Faster Data Stores

#### Themes: Distributed in-memory storage and Spark.

#### Readings:
Structured Streaming Programming Guide
Apache Foundation
https://spark.apache.org/docs/latest/structured-streaming-programming-guide.html
Through "Operations on streaming DataFrames/Datasets" section

#### Assignment 08 - Set up pipeline, Part 1 (Recommender Project)



## Week 12 - Faster Queries

#### Themes: Structured streaming, streaming queries, caching vs. stream queries

#### Readings:
Structured Streaming Programming Guide
Apache Foundation
https://spark.apache.org/docs/latest/structured-streaming-programming-guide.html
From "Streaming Queries" section to end

#### Assignment 09 - Set up pipeline, Part 2 (Recommender Project)



# Putting it All Together

## Week 13 - Understanding Data

#### Themes: Sessionization and state and model validation and management

#### Readings:
Scala:Applied Machine Learning
by Alex Kozlov, Patrick R. Nicolas, Pascal Bugnion
Sessionization (in Chapter 6. Working with Unstructured Data)

Advanced Analytics with Spark, 2nd Edition
by Uri Laserson, Sandy Ryza, Sean Owen, Josh Wills
Sessionization in Spark (in Chapter 8. Geospatial and Temporal Data Analysis on New York City Taxi Trip Data)

#### Assignment 10 - Synthesis Assignment (Recommender Project)


## Week 14 - Patterns for Data Pipelines

#### Themes: Conceptual DevOps and serverless architectures

#### Readings:
Infrastructure as Code
by Kief Morris
Chapter 1. Challenges and Principles

Network Programmability and Automation
by Jason Edelman, Matt Oswalt, Scott S. Lowe
Chapter 10. Continuous Integration (covers ci/cd, tdd, etc)

Serverless Architectures on AWS
by Peter Sbarski
Chapter 1. Going serverless

## Tutorials
Revision Control using Git (in Week 1)
The Command Line (in Weeks 1 and 2)
Jupyter Notebooks (in Weeks 2 and 3)
SQL (in Week 3)
Clouds and Virtualization (In Weeks 4 and 5)
Containers (in Weeks 4 and 5)
Schedulers (in Week 6)
APIs and Web Services (in Weeks 7 and 8)
How the Web Works: “Cache is King!” (in Week 12)


## Academic Integrity:
Please read UC Berkeley’s policies around academic integrity:
http://sa.berkeley.edu/conduct/integrity

## Avoiding Plagiarism:
Plagiarism is a serious academic offense, and students must take care not to copy code written by others. Beginning students sometimes have trouble identifying exactly when plagiarism takes place. Remember that it is generally fine to search for examples of code (for example, on forums like stackexchange). This is a normal part of programming and can help you learn. However, it is important that you understand the code you find and use what you learn to write your own statements. It is ok if a single line of code happens to match an example found on the internet, but you should not copy multiple lines at once. If in doubt, simply document the place you found your example code and ask your instructors for further guidance.

---
