# MIDS w205 - Fundamentals of Data Engineering

course material

## Building the course content (slides and docs atm)

### top-level

From the top-level directory of project, you can:

- create all slides

    make

- publish slides to berkeley

    make publish

- view slides on site

    open http://people.ischool.berkeley.edu/~mark.mims/course-development/2017-mids-w205/lectures/

- clean up

    make clean


### a single week

From a week's folder (e.g., `02-Working-with-Data`), you can:

- create slides

    make

- clean up

    make clean

- view slides locally

    open <lecture-component>.html



# Screencasts

## Editing Audio

### Reducing Noise

Using Audacity,

- open audio file
- select noise range
- go to `Effects -> Noise Reduction -> Get Noise Profile`
- select entire audio capture
- go to `Effects -> Repeat Noise Reduction`
- save audio project
- export audio.  Not sure the best format yet.  I've been using AAC in m4a
  container, but it might be better to use pcm or wav or something for
  nonlinear video edits

This is all from ["Noise Removal" Audacity (Step-By-Step
Tutorial)](https://www.youtube.com/watch?v=tAJ4Sg-nO6A).

## Editing Video

BlenderVSE ftw


# TODO

ton of easy screencasts
- docker intro
- working with data - file formats n schema n stuff
- virtualization and cloud
- hadoop walkthrough
- hadoop ecosystem

- ETL (you don't always get what you want)

then gets harder...
- schedulers
- dags

then easier
sourcing data

- apis
- web scraping
- bi interfaces

metadata

- lineage
- schema



