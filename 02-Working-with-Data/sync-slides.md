---
title: Fundamentals of Data Engineering
author: Week 02 - sync session
...

---

# 

## Assignment

## Your laptop set up

- git installed
- repos cloned: course-content, assignment-01-<user-name>
- docker installed
- shell 

<div class="notes">

</div>

## How to do a PR

- Review process from gui 

<div class="notes">

</div>

## How to do a PR from the command line

- put in steps

<div class="notes">

</div>

## Due Friday, remember do a PR

<div class="notes">
</div>

# 

## Some things about this class

## How to read

- Two screens (or devices)
- Reading
- Following along with coding

## Pacing

- What you can do
- What you can understand

<div class="notes">
We'll be reading/watching screencasts ahead of what we can do
</div>


# 

## Where are we in the pipeline

![](images/pipeline-overall.svg)

<div class="notes">
</div>

## Events???

- point
- point

<div class="notes">
</div>

## Main thing to pay attention to 2

- point
- point

<div class="notes">
</div>

# 
## Big Ideas

## Business Decisions

- All about the business

- Data-Driven Business Decisions ...are queries


<div class="notes">
in order for business decisions to be based on data, you have to be able to interact with the data.
business requirements get encoded as queries of data
</div>

## Translation

- SQL queries are really pretty easy
- How to get to the queries from the questions, sometimes not so much

<div class="notes">
</div>

# 

## Query Project

- In the Query Project, you will get practice with SQL while learning about Google Cloud Platform (GCP) and BiqQuery. You'll answer business-driven questions using public datasets housed in GCP. To give you experience with different ways to use those datasets, you will use the web UI (BiqQuery) and the command-line tools, and work with them in jupyter notebooks.

- We will be using the Bay Area Bike Share Trips Data (https://cloud.google.com/bigquery/public-data/bay-bike-share). 

## Problem Statement
- You're a data scientist at Ford GoBike (https://www.fordgobike.com/), the company running Bay Area Bikeshare. You are trying to increase ridership, and you want to offer deals through the mobile app to do so. What deals do you offer though? Currently, your company has three options: a flat price for a single one-way trip, a day pass that allows unlimited 30-minute rides for 24 hours and an annual membership. 

## Questions

- Through this project, you will answer these questions: 
  * What are the 5 most popular trips that you would call "commuter trips"?
  * What are your recommendations for offers (justify based on your findings)?



<div class="notes">
</div>

# 

## Querying Data

## Get Going: Google account

- Go to https://cloud.google.com/bigquery/
- Click on "Try it Free"
- It asks for credit card, but you get $300 free and it does not autorenew after the $300 credit is used, 

<div class="notes">
(OR CHANGE THIS IF SOME SORT OF OTHER ACCESS INFO)
</div>


## Working with BQ gui

https://bigquery.cloud.google.com/table/bigquery-public-data:san_francisco.bikeshare_status 

## Tutorial

https://www.w3schools.com/sql/default.asp

## Some annoying specific stuff about BQ

## the ;

    SELECT * 
    FROM Customers;

VS 

    SELECT * 
    FROM Customers


<div class="notes">
- Nearly all other sql implementations (and what students will see in the tutorial), end statements with a ;
- BQ doesn't
- btw, the CAPITALIZATION isn't necessary :)

</div>


## Two ways to structure in BQ


    SELECT *
    FROM [bigquery-public-data:san_francisco.bikeshare_trips]

OR 

    #standardSQL
    SELECT * 
    FROM `bigquery-public-data.san_francisco.bikeshare_trips`

<div class="notes">
- Google was going to create their own sql that worked different :)

- It's silly, but the way the table reference part, the "FROM" part, is written is different.

- So, now there's the #standardSQL flag

</div>

## The Big Difference

NO


    SELECT distinct(bikes_available) 
    FROM [bigquery-public-data:san_francisco.bikeshare_status]


YES 


    #standardSQL
    SELECT distinct(bikes_available) 
    FROM `bigquery-public-data.san_francisco.bikeshare_status`

<div class="notes">
- It's in doing things with distinct that I've noticed the biggest differences from regular (aka "standard" SQL)
- You get: Error: syntax error at: 1.1 - 1.42. SELECT DISTINCT is currently not supported. Please use GROUP BY instead to get the same effect.

</div>

## For this class

	#standardSQL
	SELECT * 
	FROM `bigquery-public-data.san_francisco.bikeshare_status`


- More similar to command line bq
- More like most other SQL implementations

<div class="notes">
We're doing this one, but you can use either
</div>

## How many events are there?

<div class="notes">
For the following slides,
Wait on the question slide for a minute to give everyone a chance to try it.
Then reveal the next slide with correct query.


- Optional: you can do these in groups and ask people to 
  * report out
  * share issues, false starts they ran into 

[Obviously more useful on more complicated queries]

</div>


##

	#standardSQL
	SELECT count(*)
	FROM `bigquery-public-data.san_francisco.bikeshare_status`


<div class="notes">
107,501,619
The point: you can use select * to actually answer questions.
</div>

## How many stations are there?

##

	#standardSQL
	SELECT count(distinct station_id)
	FROM `bigquery-public-data.san_francisco.bikeshare_status`

<div class="notes">
The point: how to count unique
</div>


## How long a time period do these data cover?

##

	#standardSQL
	SELECT min(time), max(time)
	FROM `bigquery-public-data.san_francisco.bikeshare_status`


<div class="notes">

2013-08-29 12:06:01.000 UTC	
2016-08-31 23:58:59.000 UTC	
</div>


## How many total bikes does each station have? 

<div class="notes">
what they will figure out eventually is that we have varying reports, bad sensor? human counter, who knows
</div>

## 


	#standardSQL
	SELECT docks_available + bikes_available as total_bikes
	FROM `bigquery-public-data.san_francisco.bikeshare_status`

#standardSQL
SELECT station_id, (docks_available + bikes_available) as total_bikes
FROM `bigquery-public-data.san_francisco.bikeshare_status`
GROUP BY station_id
ORDER BY total_bikes

##

	#standardSQL
	SELECT *
	FROM `bigquery-public-data.san_francisco.bikeshare_status`


# 

## Section Title Slide: Summary

## New slide

- point
- point

<div class="notes">
</div>




#

<img class="logo" src="images/berkeley-school-of-information-logo.png"/>

