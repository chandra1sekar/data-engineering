---
title: Fundamentals of Data Engineering
author: Week 02 - sync session
...

---

#
## Business Decisions

<div class="notes">
All about the business
</div>

##

Data-Driven

## 

Data-Driven Business Decisions
...are queries

<div class="notes">
in order for 
business decisions to be based on data,
you have to be able to interact with the data.

business requirements get encoded as queries of data
</div>

#
## Interfaces for data analysis:

- SQL

- DataFrames

<div class="notes">
We'd like to go over a few ways in which you'll interact directly with
data when analyzing datasets.
</div>


#
## Some General Considerations

- what functionality does it support?
- how well does it perform?
- how well does it handle scale?
- how well does it handle change?



#
## functionality

<div class="notes">
mind-numbing number of tools coming out every day
to "help" you work with data

I'd like to fold them into two categories:

- presentation...
    dashboards, reports, graphs, etc
    you are supporting business decisions

- analysis... 
    - exploration, what-if, ad-hoc
    - classifying things, etc
    - developing/training models for ML/AI

Avoid the comprehensive environments that "do it all"

Take the unix tooling approach
</div>


#
## performance

<div class="notes">
- interactive

- modern query tools perform well enough to, in some cases, completely remove
  the need for yesterday's heavy ETL pipelines
</div>


#
## scale


#
## change

<div class="notes">
</div>



#
## summary

- data-driven business decisions are encoded as queries

- query engines and interfaces play a critical role in data pipelines they
  allow you to interact directly with data

- modern query tools perform well enough to, in some cases, completely remove
  the need for heavy ETL pipelines

- avoid comprehensive environments that "do it all"... prefer the unix tooling
  approach

- prefer your data raw


#

<img class="logo" src="images/berkeley-school-of-information-logo.png"/>

