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

> - Good practices
> - Appropriate tools
> - Getting used to

<div class="notes">
For your other classes, they may use a variety of ways to get content, turn in assignments etc. 
Here, we're trying to follow good practices for data engineering and use appropriate tools. 
this will probably take some getting used to at first (unless you already use git all day every day, which is great, help your friends)
</div>

## Approach

> - Github-centric content
> - Cloud accounts
> - Dockerhub
> - Activity submissions

## Activities

- Let's get going!

<div class="notes">
With all of that in mind, let's get going!
(Cloud accounts is covered in the what is Data Engineering section)
</div>

#
## Docker

- What is docker?

<div class="notes">
What is docker? Very brief version
</div>

## Install docker


- Windows 

    https://store.docker.com/editions/community/docker-ce-desktop-windows

- Mac 

    https://store.docker.com/editions/community/docker-ce-desktop-mac


<div class="notes">
Send this out on wall notice ahead, but just in case.
</div>

##

![](images/dontpanic.jpeg)


<div class="notes">
These commands will look gnarly.
Don't worry about it, we will review....blah, blah,
For now, just follow along
</div>


## Docker set up

> - open a terminal
> - `docker pull midsw205/base`
> - `mkdir w205`
> - Mac: 
`docker run -it --rm -v /Users/<user-name>/w205:/w205 \ midsw205/base:latest`

> - exit or `ctrl-d`

<div class="notes">
Like we said, we'll get into what all those options mean etc, just keep track for now
</div>



#
## git

- What is git?

<div class="notes">
We'll go over set up of folders, install git if needed, show git hub...
</div>


## Git set up
## Get started.

> - If working on Mac or Linux, or have git installed, go to w205 folder.
> - If windows or no git, 
    docker run -it --rm -v /Users/<user-name>/w205:/w205 midsw205/base:latest

## Clone the repo
> - `cd w205`
> - 
    git clone https://github.com/mids-w205-<instructor-last-name>/signup-<git-user-name>/

## Open, Change, Close  `README.md` 
> - `nano README.md`
> - change line
> - `ctrl-o`
> - return
> - `ctrl-x`
> - Now you're out of nano, but still in the container.

<div class="notes">
Or just use whatever text editor you have, these are basically directions for doing this in the container.
</div>

## Git: commit changes

> - `git status`
> - `git add README.md`
> - `git commit -m 'my new readme'`
> - The first time you commit, it doesn't know who you are.
> - `git config --global user.email "you@example.com"`
> - `git config --global user.name "Your Name"`
> - `git commit -m 'my new readme'`
> - `git push`

## After all that,
- Mac & Linux users
- Windows users
- for today, you used docker, 
- What do we need to do going forward...

<div class="notes">
- What do windows users need to do?
- Will have droplet for web login if nothing else works (which we will slack to other instructors)
</div>

## Git: submit a PR
> - All assignments submitted as PRs
> - https://github.com/mids-w205-martin-mims/signup-<user-name>
> - Click on README.md
> - Click on edit button
> - Make a change
> - At bottom of screen "Commit changes" section
> - Select "Create a new branch for this commit and start a pull request"
> - Enter PR name & description
> - Click "Propose file change" button
> - Assign instructors as reviewers
> - Click "Create pull request" button

<div class="notes">
Do this in the gui
</div>





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

## AWS

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
This pipeline is your anchor, basically where are we and how does here relate to the rest of the class
</div>

#
## How this class works
## Syllabus

- Link: 
https://github.com/mids-w205-martin-mims/course-content

<div class="notes">
Prereqs
Video links
Readings
</div>

## Asyncronous Content

- Linked in: 

    https://github.com/mids-w205-martin-mims/course-content/blob/master/01-Introduction/async-videos.md

- Same as in ISVC, but you can access it all in one place here.

## Readings

> - No one textbook available for this course.
> - Using subscription service to cover the range of topics.
> - https://www.safaribooksonline.com/pricing/
> - Two Options:
> - Individually $39/month (can stop whenever you want)
> - Also sections could go in as a team (up to 25 people) - 1 year subscription for $399
> - Quick note: Get the mobile apps.

## Prerequisites

> - Resources listed under prereqs
> - Safari has tons of other materials you can help yourself with.

## Course Outline

> - 4 sections:  
> - 3-week Introduction
> - 5-week Basics section 
> - 4-week Streaming Data section
> - Putting it All Together


<div class="notes">
- 3-week Introduction covers the basics of storage and retrieval concepts and tools
- 5-week Basics section  provides a deeper exploration of working with data and data pipelines
- 4-week section that focuses on Streaming Data; and a 
- 1-week wrapup, Putting it All Together, integrates concepts and skills from the entire course into a cohesive model of the data pipeline.
</div>

## Class flow

<div class="notes">
This section is a walk through of how we will iterate through assignments.
</div>

## Class 1

> - Preview, discussion, walkthrough set up for github for Assignment 1

## Between Class 1 & Class 2

> - async material for Week 1
> - Readings for Week 1
> - Assignment 01


## Class 2

> - Review Assignment 01, questions, where did you hit a wall?
> - Some lectur-ish stuff on this week's topic
> - Preview Query Project (spans Assignments 2-5)
> - Preview, discussion, SQL query activities to prepare for Assignment 2
> - Final Assignment 01 due on Friday

## Between Class 2 & Class 3

> - async material for Week 2
> - Readings for Week 2
> - Assignment 02


## Class 3

> - Review Assignment 02, questions, where did you hit a wall?
> - Some lectur-ish stuff on this week's topic
> - Preview, discussion, do google cloud platform setup and sql statements for Assignment 03
> - Final Assignment 02 due on Friday


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
talk about survey results?
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

