# MIDS w205 - Fundamentals of Data Engineering 
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

The 12 assignments will cumulatively build into 3 projects: the Query Project, the Tracking User Activity Project and the Understanding User Behavior Project. Each assignment will be a part of one of these projects. Each assignment will be a hands-on lab that is completed both individually and revisited during the synchronous weekly group sessions. Ten of the twelve assignments will be graded.

Your final grade will be as follows:

- 10% for each of the 10 graded assignments

These assignments are the core of this course. Your work on them is one of the best ways for you to learn. To allow you to get the most out of each assignment, we iterate through each of them. For example, for Assignment 1: 1) you'll work in groups and hear from us about the content of the assignment in Week 1, then 2) you'll work on it independently and/or in groups during the week, coming to Week 2's synchronous session with an attempt at the assignment and any questions you have, next 3) we will review it and address questions during Week 2's synchronous session, and finally, 4) the final version of the assignment will be due the next day. 

## Readings
Most readings are available through a subscription to https://www.safaribooksonline.com/. Other readings are blogposts and links.


## Prerequisites

- Previous experience with Python.
- Basic knowledge of Unix/Linux commands and tools as well as concepts such as processes, file systems.
- In addition we'll use Docker, Git, and SQL as well as other tools.
- If you feel like you're not where you'd like to be with these technologies/tools, here are some resources to get up to speed. There are options, pick which one best suits your needs.

#### SQL

    SQL Tutorial
    w3schools.com
    https://www.w3schools.com/sql/default.asp

    Learning SQL, 2nd Edition
	by Alan Beaulieu
	https://www.safaribooksonline.com/library/view/learning-sql-2nd/9780596801847/

#### The Command Line

	Learning the Shell
	by William E. Shotts, Jr.
	http://linuxcommand.org/lc3_learning_the_shell.php

#### Git

	Pro Git book
	by Scott Chacon and Ben Straub 
	https://git-scm.com/book/en/v2

#### Python

	Python for Data Analysis, 2nd Edition
	by William Wesley McKinney
	https://www.safaribooksonline.com/library/view/python-for-data/9781491957653/

#### Docker

	Getting Started with Docker
	https://docs.docker.com/get-started/

	Using Docker
	by Adrian Mouat
	https://www.safaribooksonline.com/library/view/using-docker/9781491915752/

## Course Outline
The course consists of 4 sections: A 3-week Introduction that covers the basics
of storage and retrieval concepts and tools; a 5-week Basics section that
provides a deeper exploration of working with data and data pipelines; a 4-week
section that focuses on Streaming Data; and a concluding section, Putting it
All Together, that integrates concepts and skills from the entire course into a
cohesive model of the data pipeline.

In addition to the sequenced material covered, the course also includes
Tutorial materials that focus on technical skills associated with data
engineering technologies, tools, and platforms. These tutorials also provide a
practical foundation for the discussions and activities that will take place in
the live classroom for specific weeks in the term.

# Introduction

## Week 01 - Introduction

#### Themes: What is Data Engineering? Gathering event data. Get started with queries.

#### Readings

>   Data Science vs. Data Engineering   
>   Insight Data Science blog 
>   https://blog.insightdatascience.com/data-science-vs-data-engineering-62da7678adaa

>   Network Programmability and Automation 
>   by Jason Edelman, Matt Oswalt, Scott S. Lowe
>   Chapter 8. Source Control with Git
>   https://www.safaribooksonline.com/library/view/network-programmability-and/9781491931240/ch08.html#sourcecontrol

>   Analytics For Hackers: How To Think About Event Data
>   by Michelle Wetzler
>   https://blog.keen.io/analytics-for-hackers-how-to-think-about-event-data-cabeefe1f3d9

#### Asynchronous Content

    1.1 - Welcome
      1.1.1 What is Data Engineering? [lecture]
      1.1.2 What will I be able to do after this course? [lecture]

    1.2 - This Course
      1.2.1 Organization and Approach [lecture]

    1.3 - Data Pipelines
      1.3.1 What's a Data Pipeline? [lecture]
      1.3.2 Typical Pipeline Components [lecture]

    1.4 - Events Everywhere
      1.4.1 Device Events [lecture]
      1.4.2 User Events [lecture]
      1.4.3 Event Streams [lecture]


## Week 02 - Working with Data

#### Themes: Intro to data, metadata, and some basic tools for working with data.

#### Readings

>   Network Programmability and Automation
>   by Jason Edelman, Matt Oswalt, Scott S. Lowe
>   Chapter 5. Data Formats and Data Models
>   https://www.safaribooksonline.com/library/view/network-programmability-and/9781491931240/ch05.html#dataformats


>   Python for Data Analysis, 2nd Edition
>   by William Wesley McKinney
>   Chapter 2.2 IPython Basics
>   https://www.safaribooksonline.com/library/view/python-for-data/9781491957653/ch02.html#ipython_basics

#### Asynchronous Content

    2.1 Working with Data
      2.1.1 Introduction [lecture]
      2.1.2 Formats [screencast]
      2.1.3 Schema/Types [screencast]


    2.2 Tools for Working with Data
      2.2.1 Introduction to Tools  [screencast]
      2.2.2 Introduction to the Command Line [tutorial]
      2.2.3 Using the The Command Line [tutorial]
      2.2.4 Introduction to Jupyter Notebooks [tutorial]
      2.2.5 Introduction to Docker [tutorial]


#### Due Friday after Week 2 Synchronous Session: 
- Assignment 01: Set up and prerequisites



## Week 03 - Welcome to the Queryside

#### Themes: SQL, query tools

#### Readings

>   Designing Data-Intensive Applications, 1st Edition
>   Martin Kleppmann
>   Chapter 2. Data Models and Query Languages
>   https://www.safaribooksonline.com/library/view/designing-data-intensive-applications/9781491903063/ch02.html#ch_datamodels


>   Learning SQL, 2nd Edition
>   by Alan Beaulieu
>   Chapter 3. Query Primer
>   https://www.safaribooksonline.com/library/view/learning-sql-2nd/9780596801847/ch03.html

#### Asynchronous Content

    3.1 What is the queryside?
      3.1.1 Revisiting Pipelines [lecture]
      3.1.2 Immutability [lecture]

    3.2 Query Tools
      3.2.1 Queryside World  [screencast]
      3.2.2 Athena [screencast]
      3.2.3 BigQuery [screencast]

    3.3 Sneak Peek
      3.3.1 Caching [screencast]
      3.3.2 Using Jupyter Notebooks [tutorial]
      3.3.3 Using Docker [tutorial]
      3.3.4 Using Containers to Run Services with Docker [tutorial] 


#### Due Friday after Week 3 Synchronous Session: 
- Assignment 02: Querying data with BigQuery


# The Basics

## Week 04 - Storing Data

#### Themes: Relational and NoSQL datastores

#### Readings

>   Using Docker
>   by Adrian Mouat
>   Chapter 1. The What and Why of Containers
>   https://www.safaribooksonline.com/library/view/using-docker/9781491915752/ch01.html#what_and_why

>   Modern Linux Administration
>   by Sam R. Alapati
>   Chapter 1. Modern Linux System Administration
>   https://www.safaribooksonline.com/library/view/modern-linux-administration/9781491935941/ch01.html#idm139918689681584

#### Asynchronous Content

    4.1 Introduction
      4.1.1 - Where are we in the Pipeline? [lecture]

    4.2 Relational Data Stores
      4.2.1 - Relational Databases [lecture]
      4.2.2 - Relational Databases - Relations [lecture]
      4.2.3 - Relational Databases - Normalization [lecture]

    4.3 NoSQL Data Stores
      4.3.1 - NoSQL Data Stores [lecture]
      4.3.2 - NoSQL - Relational Model [screencast]
      4.3.3 - NoSQL - Document Store [screencast]
      4.3.4 - NoSQL - Key-Value Store [screencast]


#### Due Friday after Week 4 Synchronous Session: 
- Assignment 03 - Querying data from the BigQuery CLI - set up (Query Project)


## Week 05 - Storing Data II

#### Themes: Introduction to cloud concepts and Hadoop

#### Readings

>   Hadoop: The Definitive Guide, 4th Edition
>   by Tom White
>   Chapters 1-3
>   https://www.safaribooksonline.com/library/view/hadoop-the-definitive/9781491901687/

#### Asynchronous Content

    5.1 Introduction to the Cloud
      5.1.1 - Virtualization and Containers [screencast]
      5.1.2 - Infrastructure Encapsulation and Isolation [screencast]
      5.1.3 - Composing Containers [screencast]
      5.1.4 - Failure in Distributed Systems [lecture]

    5.2 Hadoop
      5.2.1 - Hadoop [lecture]
      5.2.2 - Hadoop Walkthrough [screencast]
      5.2.3 - The Hadoop Ecosystem [screencast]
      5.2.4 - Using Hadoop [screencast]
    
#### Due Friday after Week 5 Synchronous Session: 
- Assignment 04 - Querying data from BigQuery - finishing up  (Query Project)



## Week 06 - Transforming Data

#### Themes: ETL and its discontents, more Hadoop, and container management

#### Readings

>   Designing Data-Intensive Applications, 1st Edition
>   Martin Kleppmann
>   Chapter 10. Batch Processing
>   https://www.safaribooksonline.com/library/view/designing-data-intensive-applications/9781491903063/ch10.html#ch_batch

>   Designing Data-Intensive Applications, 1st Edition
>   Martin Kleppmann
>   Chapter 11. Stream Processing
>   https://www.safaribooksonline.com/library/view/designing-data-intensive-applications/9781491903063/ch11.html#ch_stream

>   Hadoop: The Definitive Guide, 4th Edition
>   by Tom White
>   Chapter 4. YARN
>   https://www.safaribooksonline.com/library/view/hadoop-the-definitive/9781491901687/ch04.html

#### Asynchronous Content

    6.1 Introduction
      6.1.1 - Transform Section of Pipeline [lecture]

    6.2 ETL
      6.2.2 - You don't always (aka usually) get what you want [screencast]

    6.3 Hadoop ETL
      6.3.1 - Running Hadoop Jobs [lecture]
      6.3.2 - Hadoop ETL [screencast]
      6.3.3 - Introduction to Spark [screencast]

    6.4 Container Management
      6.4.1 - Distributed Execution Models [screencast]
      6.4.2 - Introduction to Schedulers [screencast]
      6.4.3 - Using Schedulers [screencast]


#### Due Friday after Week 6 Synchronous Session: 
- Assignment 05 - Employ notebooks to synthesize query project results (Query Project)


## Week 07 - Sourcing Data

#### Themes: Data and its provenance, security and privacy

#### Readings

>   Modern Linux Administration
>   by Sam R. Alapati
>   Chapter 15. Security and Compliance in the Modern Systems Environment
>   https://www.safaribooksonline.com/library/view/modern-linux-administration/9781491935941/ch15.html

#### Asynchronous Content

    7.1 Pipeline Context
      7.1.1 * Pipeline Context [lecture]

    7.2 Where did the data come from?
      7.2.1 - APIs [screencast]
      7.2.2 - Web pages [screencast]
      7.2.3 - Email attachments [screencast]
      7.2.4 - Databases [screencast]
      7.2.5 - Cloud Storage [screencast]
      7.2.6 - Application Pipelines [screencast]

    7.3 What do you want to know about the data you get?
      7.3.1 - Lineage [screencast]
      7.3.2 - Version [screencast]
      7.3.3 - Schema [screencast]

    7.4 Security and Privacy
      7.4.1 Security and Privacy [lecture]
      7.4.2 PII [screencast]

#### Due Friday after Week 7 Synchronous Session: 
- Assignment 06 - Get and clean data (Tracking User Activity Project)


## Week 08 - Querying Data

#### Themes: Querying with partition keys and query planning

#### Readings

>   Designing Data-Intensive Applications, 1st Edition
>   by Martin Kleppmann
>   Chapter 6. Partitioning
>   https://www.safaribooksonline.com/library/view/designing-data-intensive-applications/9781491903063/ch06.html#ch_partitioning

#### Asynchronous Content

    8.1 Querying
      8.1.1 - Pipeline Context [lecture]
      8.1.2 - Base decisions on queries [screencast] 
      8.1.3 - Query Walkthrough [screencast]

    8.2 Tools
      8.2.1 - Tools [screencast]

    8.3 Partitions
      8.3.1 - Querying with Partition Keys [screencast] 
      8.3.2 - How to take advantage of partitions [screencast]

    8.4 Query Planning
      8.4.1 - Query Optimization [screencast]
      8.4.2 - Using the Tools [screencast]

#### Due Friday after Week 8 Synchronous Session: 
- Assignment 07 - Set up pipeline (Tracking User Activity Project)


# Streaming

## Week 09 - Ingesting Data

#### Themes: Ingesting streaming data, using Kafka, considerations of latency.

#### Readings

>   Kafka: The Definitive Guide, 1st Edition
>   by Gwen Shapira, Neha Narkhede, Todd Palino
>   Chapter 7. Building Data Pipelines
>   https://www.safaribooksonline.com/library/view/kafka-the-definitive/9781491936153/ch07.html


#### Asynchronous Content

    9.1 Pipeline Context
      9.1.1 - Where are we in the Pipeline? [lecture]

    9.2 Kafka
      9.2.1 - Distributed Messaging [lecture]
      9.2.2 - Kafka Walkthrough [screencast]
      9.2.3 - Where are the data coming from? [screencast]
      9.2.4 - Latency [lecture]
      9.2.5 - Batch vs. Real Time [screencast]
      9.2.6 - Driven by Queries [screencast]

#### Due Friday after Week 9 Synchronous Session: 
- Assignment 08 - Build and Write-up Pipeline (Tracking User Activity Project)



## Week 10 - Transforming Streaming Data

#### Themes: NoETL, batch vs streaming, in-memory computing

#### Readings

>   High Performance Spark, 1st Edition
>   by Holden Karau, Rachel Warren
>   Chapter 2. How Spark Works
>   https://www.safaribooksonline.com/library/view/high-performance-spark/9781491943199/ch02.html

>   Learning Spark
>   by Andy Konwinski, Holden Karau, Matei Zaharia, Patrick Wendell
>   Chapter 10. Spark Streaming
>   https://www.safaribooksonline.com/library/view/learning-spark/9781449359034/ch10.html

#### Asynchronous Content

    10.1 NoETL
      10.1.1 - Pipeline Context [lecture]

    10.2 Modes of Execution
      10.2.1 - Batch -vs- Streaming [screencast]
      10.2.2 - Single Event Processing [screencast]
      10.2.3 - Microbatch [screencast]
      10.2.4 - Continuous Applications - Handling Batch and Streaming Data in the Same System [screencast]

    10.3
      10.3.1 - In Memory Computing [screencast]

    10.4 Take Action!
      10.4.1 * Take Action! [lecture]

#### Due Friday after Week 10 Synchronous Session: 
- Assignment 09 - Define Your Pipeline (Understanding User Behavior Project)



## Week 11 - Storing Data III

#### Themes: Distributed in-memory storage and Spark

#### Readings

>   Structured Streaming Programming Guide
>   Apache Foundation
>   https://spark.apache.org/docs/latest/structured-streaming-programming-guide.html
>   Through "Operations on streaming DataFrames/Datasets" section

#### Asynchronous Content

    11.1 Pipeline Context
      11.1.1 - Pipeline Context [lecture]

    11.2 In Memory
      11.2.1 - Streaming and Spark [screencast]
      11.2.2 - Structured Streaming [screencast]

    11.3 Resource Selections
      11.3.1 - Dedicated Stream Processing [screencast]

    11.4 Distributed In-memory Storage
      11.4.1 - Distributed In-memory Storage [screencast]

    11.5 Activity
      11.5.1 - User Activity [lecture]

#### Due Friday after Week 11 Synchronous Session: 
- Assignment 10 - Set up pipeline, Part 1 (Understanding User Behavior Project)



## Week 12 - Querying Data II

#### Themes: Structured streaming, streaming queries, caching vs. stream queries

#### Readings

>   Structured Streaming Programming Guide
>   Apache Foundation
>   https://spark.apache.org/docs/latest/structured-streaming-programming-guide.html
>   From "Streaming Queries" section to end

#### Asynchronous Content

    12.1 Queries
      12.1.1 - Caching -vs- Stream Queries [screencast]
      12.1.2 - Caching and the Web [screencast]
      12.1.3 - A walk down memory lane - data mining [screencast]
      12.1.4 - Replay [screencast]
      12.1.5 - Caching queries [screencast]

#### Due Friday after Week 12 Synchronous Session: 
- Assignment 11 - Set up pipeline, Part 2 (Understanding User Behavior Project)



# Putting it All Together

## Week 13 - Understanding Data

#### Themes: Sessionization and state and model validation and management

#### Readings

>   Scala:Applied Machine Learning
>   by Alex Kozlov, Patrick R. Nicolas, Pascal Bugnion
>   Sessionization (in Chapter 6. Working with Unstructured Data)
>   https://www.safaribooksonline.com/library/view/scalaapplied-machine-learning/9781787126640/ch32s04.html

>   Advanced Analytics with Spark, 2nd Edition
>   by Uri Laserson, Sandy Ryza, Sean Owen, Josh Wills
>   Sessionization in Spark (in Chapter 8. Geospatial and Temporal Data Analysis on New York City Taxi Trip Data)
>   https://www.safaribooksonline.com/library/view/Advanced+Analytics+with+Spark,+2nd+Edition/9781491972946/ch08.html#idm140398878264880

#### Asynchronous Content

    13.1 Context
      13.1.1 - Pipeline Context [lecture]

    13.2 Sessionization and State
      13.2.1 - Sessionization and state for action [lecture]
      13.2.2 - Ingested Events [screencast]
      13.2.3 - Low Latency Ingested Events [screencast]
      13.2.4 - Architectural Patterns for Action [screencast]

    13.3 Models
      13.3.1 - Model Validation [screencast]
      13.3.2 - Model Management [screencast]

#### Due Friday after Week 13 Synchronous Session: 
- Assignment 12 - Synthesis Assignment (Understanding User Behavior Project)


## Week 14 - Patterns for Data Pipelines

#### Themes: Conceptual DevOps and serverless architectures

#### Readings

>   Infrastructure as Code
>   by Kief Morris
>   Chapter 1. Challenges and Principles
>   https://www.safaribooksonline.com/library/view/infrastructure-as-code/9781491924334/ch01.html#chapter-challenges

>   Network Programmability and Automation
>   by Jason Edelman, Matt Oswalt, Scott S. Lowe
>   Chapter 10. Continuous Integration
>   https://www.safaribooksonline.com/library/view/network-programmability-and/9781491931240/ch10.html#cicd

>   Serverless Architectures on AWS
>   by Peter Sbarski
>   Chapter 1. Going serverless
>   https://www.safaribooksonline.com/library/view/serverless-architectures-on/9781617293825/kindle_split_013.html

>    The Case for Learned Index Structures
>    by Tim Kraska, Alex Beutel, Ed H. Chi, Jeffrey Dean, & Neoklis Polyzotis 
>    https://www.arxiv-vanity.com/papers/1712.01208v1/


#### Asynchronous Content

    14.1 DevOps
      14.1.1 - Infrastructure as Code [screencast]
      14.1.2 - Testing [screencast]
      14.1.3 - CI/CD  [screencast]
      14.1.4 - Logging and Monitoring [screencast]
      14.1.5 - Automation [screencast]
      14.1.6 - The Development Process [screencast]

    14.2 Serverless Architectures
      14.2.1 - The Future of Data Engineering [screencast]
      14.2.2 - AWS Kool-aid stack [screencast]
      14.2.3 - GCP Kool-aid stack [screencast]


## Academic Integrity
Please read UC Berkeley’s policies around academic integrity:
http://sa.berkeley.edu/conduct/integrity

## Avoiding Plagiarism
Plagiarism is a serious academic offense, and students must take care not to copy code written by others. Beginning students sometimes have trouble identifying exactly when plagiarism takes place. Remember that it is generally fine to search for examples of code (for example, on forums like stackoverflow). This is a normal part of programming and can help you learn. However, it is important that you understand the code you find and use what you learn to write your own statements. If in doubt, simply document the place you found your example code and ask your instructors for further guidance.
