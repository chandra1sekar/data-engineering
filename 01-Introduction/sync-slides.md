---
title: Fundamentals of Data Engineering
author: Week 01 - sync session
...

---

# 
## Week 1 - Overview

- Introductions
- Set up your working environment for this class
- Review syllabus, course goals, processes & tools ...

<div class="notes">
See ~/taylor-oreilly/data-engineering-course/solutions/setup.md
</div>

## Introductions

<div class="notes">
Introduce yourself :)
Student introductions
</div>

## In this class, you will

> - Gain exposure to basic problems associated with data and data-driven decision-making
> - Develop a working knowledge of some tools/techniques used to solve these problems
> - Learn where to go for help and more info

<div class="notes">

</div>


## Approach

##

> - Hands-on
> - Just enough
> - Motivated content
> - Adaptible to change

<div class="notes">
hands on - activities are da bomb

motivated content: use everything we cover

just enough DE

multiple exposures - hit everything 3 xs with increasing levels of detail

context anchors - explain what you mean by this

ideal outcome is the prepare them to learn further independently (including stack overflow etc)

prefer scale and latency free concepts

</div>


## Process/Procedures

<div class="notes">
For your other classes, they may use a variety of ways to get content, turn in assignments etc. 
Here, we're trying to follow good practices for data engineering and use appropriate tools. 
this will probably take some getting used to at first (unless you already use git all day every day, which is great, help your friends)
</div>

##

- Github-centric content
- Cloud accounts
- Dockerhub
- Activity submissions

## Activities

- Let's get going!

<div class="notes">
With all of that in mind, let's get going!
(Cloud accounts is covered in the what is Data Engineering section)
</div>

#
## CLI
- Where's (what's) my terminal???
- Windows users

<div class="notes">
basic cli activity - point them to shotts for more
What do windows users need to do?
Fallback for windows or anyone else who can't get going here.
</div>

## CLI stuff everyone needs to be able to do

> - Where am I?
  * `pwd`
> - Get to home!
  * `cd`
> - Make a directory
  * `mkdir w205`

#
## git

- What is git?

<div class="notes">
We'll go over set up of folders, install git if needed, show git hub...
</div>

## Install git

- What is git?

<div class="notes">
Even if not doing this here, will have as notes. install git if needed
</div>

## Git set up

> - `cd w205`
> - git clone <repo-name>
> - PR walkthrough

<div class="notes">
This will cover what they'll need to turn in assignments.
Which repo
How to do a PR on that
</div>



#
## Docker

<div class="notes">
What is docker? Very brief version
</div>

## Install docker

<div class="notes">
where do you go, have they done this already, are we requiring them to b4 1st class?
</div>

## Docker set up

> - `docker pull midsw205/base`
> - `cd w205/`
> - `docker run -it --rm -v`pwd`:/w205 midsw205/base:latest`




# 
## What is Data Engineering?

## Things are changing quickly

https://www.coursera.org/learn/gcp-big-data-ml-fundamentals

<div class="notes">
Watch the preview video for Google's Coursera course as a group

- What surprised you about the points made?
- Slides on gcp, DO, & aws
- What they will set up for gcp???

</div>

## What surprised you about the points made?

- Enter 2 things on chat that you noticed.

## Virtualization
<div class="notes">
- We'll talk a lot about virtualization later, but important to understand that many orgs are going totally this way
- You will use accts for all of these, but what set up today?
</div>

## GCP

<div class="notes">
What is it?
Link?
</div>

## DO
<div class="notes">
What is it?
Link?
</div>

### AWS
<div class="notes">
What is it?
Link?
</div>




## Data Engineering Jobs

- Search "data engineering jobs"
- What are companies looking for in skills, experience, competencies?

<div class="notes">
Google data engineering jobs & read ads (between 5&10).
- What are companies looking for in skills, experience, competencies?
</div>

## Just enough
<div class="notes">
You'll hear this over and over, but basics of worldview
...
</div>

## Pipeline: Contextual Anchor

![](images/pipeline-overall.svg)

<div class="notes">
This pipeline is your anchor, basically where are we and how does here relate to the rest of the class?
</div>

#
## How this class works
## Syllabus

- Link: https://classroom.github.com/classrooms/34870768-mids-w205-fundamentals-of-data-engineering-martin-mims/????????

<div class="notes">
syllabus
√assignment flow
√Go through all 3 projects? 
</div>

## Assignment flow
<div class="notes">
This section is a walk through of how we will iterate through assignments.
</div>

## Class 1

> - Preview, discussion, walkthrough set up for github for Assignment 1

## Class 2

> - Review Assignment 1, questions, where did you hit a wall?
> - Some lectur-ish stuff on this week's topic
> - Preview Query Project (spans Assignments 2-5)
> - Preview, discussion, SQL query activities to prepare for Assignment 2
> - Final Assignment 1 due next day

## Class 3

> - Review Assignment 2, questions, where did you hit a wall?
> - Some lectur-ish stuff on this week's topic
> - Preview, discussion, do google cloud platform setup and sql statements for Assignment 3
> - Final Assignment 2 due next day


#
## Student Projects

## Student Projects

1. Querying Data
2. Tracking User Activity
3. Understanding User Behavior

## Querying Data

- Use existing tools/pipeline/dataset
- Answer basic business questions

<div class="notes">
data-driven business decisions

prompt/reinforce the connection

validation/testing?  (how good are our results?)

(intro to model management?)
</div>

## Tracking User Activity

- Use provided pipeline components
- Transform/store data
- Answer business questions
- Bonus:
    - Trigger notifications

<div class="notes">
"Catching and Transforming Data using plumbing that's provided"

Catching Data

Classifying Events
Filtering/Sorting/Grouping
Transforming Data

Storing Data
</div>

## Understanding User Behavior

- Assemble an end-to-end pipeline
- Ingest/transform/store data
- Answer comprehensive business questions
- Bonus:
    - Manage sessionization / state

<div class="notes">
end-to-end pipeline for understanding behavior

you assemble the plumbing

baseline: queries to answer questions about the user activity

bonuses as above
</div>


## Levels of Expertise
<div class="notes">
If you're brand new to something, you'll get it taken care of. If you've nailed it, get creative
</div>

#
## 
<div class="notes">
</div>
#
## 
<div class="notes">
</div>
#
## 
<div class="notes">
</div>

#

<img class="logo" src="images/berkeley-school-of-information-logo.png"/>

