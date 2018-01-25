---
title: Fundamentals of Data Engineering
author: Week 04 - sync session: Storing Data
...

---


#
## While we're getting started

- Review your Project Questions 
- Get ready to share

::: notes
I've been following this at about 5 after with a breakout.
- Check in with each group on their solution to the assignment
- Answer questions as people have them on what they had trouble with
:::

#
## Overview
- Go over Assignment 3 results
- 
-
-


# 

## Our Project Questions
- What is a trip?
- What are the most common trips?
- How does this differ based on trip type (commuter vs all)?
- What is a commuter trip?

::: notes
- What is a commuter trip?
  * A trip during rush hour
  * Write a query to determine if a trip happens from 7-9 am or 4-7 pm. (or how many trips do...)
:::


## Due Friday (PR)




## Housekeeping

- Class flow

:::notes
The following few slides are just reviewing the flow of when things are due and what readings/videos go with what.
:::

## Between Class 3 & Class 4

> - async material in Week 3 syllabus
> - Readings in Week 3 syllabus
> - Assignment 03


## Class 4 (i.e., today)

> - Review Assignment 03, questions, where did you hit a wall?
> - Some lectur-ish stuff/activities on Assignment 04/Week 4 async topic
> - Review Query Project (spans Assignments 2-5)
> - Preview, discussion, do contentprep activities for Assignment 04 (refining and answering your project questions)
> - Final Assignment 03 due on Friday

## Between Class 4 & Class 5

> - async material in Week 4 syllabus
> - Readings in Week 4 syllabus
> - Assignment 04

## Where are we in project (ie. how progressing to end it)

- Assignment 4: Answer your Project Questions
- Assignment 5: Use Jupyter Notebook to do some visualizations and write up your reasoning for the recommendations you choose to make.

::: notes
use bigquery or bq cli for assignment 4
:::


# 

## Need to do command line commit, branch and PR 

## Athena & AWS cli tool (aws)

::: notes
- watched video on it week 3 async
*** SAVE FOR WEEK 5
:::




#
## Docker: Where am I?

::: notes
By week 4, they should have watched this, so ***need an activity*** to use it, not just walk them through

Activity: something with docker compose?
Also: Where the heck am I activity
:::


## Basic commands

::: notes
- slides on basic docker commands, walk them through it
docker run something
docker ps (see what's running)
docker ps -a
docker run -d something (run in background)

:::

## Clean up docker 
::: notes
docker rm -f <name-of-container>
:::


## Idiomatic docker


::: notes
I hope some of this simplifies when we start using the containers to _just_ run a command... i.e.,
`docker run [<opts>] <image> [<command>]`
... e.g., 
ME: check this query for backticks from bq cli sql
`docker run -it --rm midsw205/base bq query --use_legacy_sql=false 'select count(*) from mytable'`
in one go (edited)

then they're only "in" one place
:::


## Docker compose

- What is docker compose?

## Docker compose .yml file


::: notes
Save the following snippet as `~/w205/kafka/docker-compose.yml` on your host
filesystem
:::

## Docker compose spin things up

- `cd ~/w205/kafka`
- `docker-compose up -d`
- `docker-compose ps`

::: notes
- This is the start of spinning up things that will lead to projects 2&3
- Have them go through on command line, talk about what is happening.
:::

#
## Summary

#

## 


::: notes
md works here
:::

# 

## Extras

## Jupyter Notebook shortcut link
## Jupyter Notebooks

- what to do to get started
- some viz 

::: notes
run it in the container again (like I do on elias? on fwf?)
:::


#

<img class="logo" src="images/berkeley-school-of-information-logo.png"/>

