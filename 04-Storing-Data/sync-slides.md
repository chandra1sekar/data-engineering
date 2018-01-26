---
title: Fundamentals of Data Engineering
author: Week 04 - sync session
...

---


#
## While we're getting started

- Review your Project Questions 
- Get ready to share

::: notes
Breakout at about 5 after the hour:
- Check in with each group on their solution to the assignment
- Answer questions as people have them on what they had trouble with
- Usually takes 10-20 minutes
:::

#
## Overview
- Go over Assignment 3 results
- PRs from the command line
- Docker compose, beginning


# 

## Assignment 3: Our Project Questions
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
- The following few slides review the flow of when things are due and what readings/videos go with which week.
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

## Where are we in the Query Project?

- Assignment 4: Answer your Project Questions
- Assignment 5: Use Jupyter Notebook to do some visualizations and write up your reasoning for the recommendations you choose to make.

::: notes
use bigquery or bq cli for assignment 4
:::


# 

## Creating a GitHub Pull-Request(PR)
- From the command-line

## Clone a repo from GitHub

    git clone https://github.com/mids-w205-martin-mims/assignment-02-htmartin
    cd assignment-02-htmartin

## Create a branch to work from

    git branch my-cool-feature

## Switch to that branch

    git checkout my-cool-feature

## Make changes to code

    vi README.md

::: notes
- M: no vi in container? droplets?
:::

## Commit those changes

    git commit -m'updated README' README.md

## Push those up to GitHub

    git push origin my-cool-feature


## Note  
- If this is the first time you've pushed to the remote `my-cool-feature` branch, then this command will automatically _create_ that branch in your github repo and then push your changes to it.

## Pull Request from the GitHub Web-UI

- Select "New Pull-Request"

- Select branches so that you are "Requesting to merge changes from `my-cool-feature` branch _into_ `master`."

- Select your instructor(s) to review.

- Submit






#
## Docker: Where am I?

- We've worked with Docker
- We've explore cli ways to find out what's up with data
- How do we find our way around with Docker?

::: notes
docker run -it --rm -v ~/w205:/w205 midsw205/base bash

:::

## Run the regular container

```
docker run -it --rm -v ~/w205:/w205 midsw205/base bash
```

## What conatiners are running right now?

- New terminal window

- `docker ps`

## What conatiners exist?

- `docker ps -a`

## Container name

- `fervent_austin` is my running `midsw205/base:latest` container

## What images do I have?

- Images vs. containers

- `docker images`

## Image name 

- Need both repository & tag

- e.g., `midsw205/base:latest`




## Clean up containers

docker rm -f <name-of-container>

::: notes
:::


## Idiomatic docker

- start the container
-`pwd` in midsw205/base:latest

- exit container
- from prompt 

```
docker run -it --rm -v ~/w205:/w205 midsw205/base pwd
```
 



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

- `cd w205`
- `mkdir kafka`

- put `docker-compose.yml` file that is in `mids-w205-martin-mims/course-content/04-Storing-Data` in your ~/w205/kafka directory

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

