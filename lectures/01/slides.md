
---
title: "Just Enough Data Engineering"
date: MIDS - Fall 2017
...

---

# Introduction

<div class="notes">
Speaker Notes
</div>


# Data Engineering
##

## What is Data Science?

Solve business problems using data

## What is Data Engineering?

The plumbing required to solve business problems using data

## Why do I care?

Working as a data scientist, you eat, sleep, and breathe data!

Strive to be proficient with every aspect of data:

- kinds (device data, user data, ...)
- formats (avro, parquet, json, csv, ...)
- sources (wearables, mobile apps, web, ...)
- tools (jupyter, hadoop, kafka, spark, ...)
- ...

## Why do I care?

You'll also need to interact with

- other data scientists
- data engineers
- business analysts
- stakeholders / decision-makers
- users

<div class="notes">
It's useful to have visibility into these domains
</div>


# This Course
##

_Just enough_ data engineering to be effective as a data scientist

<div class="notes">
A survey of the domain of Data Engineering
</div>

## Organization

Business or Technology?

<div class="notes">
Ideally we'd present a business-centric approach to data engineering.  It's a critical
component.
[Explain why this is so important here?]

That's too hard here for a variety of reasons that'll become apparent throughout this course.

Instead, we'll compromise.  We'll use a technology-centric approach to organize the material
but we'll be sure to motivate all examples and activities with concrete business problems.
</div>

## Organization

Technology


# Data Pipelines
##

## What do we actually need?

- a way to interact with data
- analytical capabilities
- available
- reliable (consistent & testable results)
- scalable
- maintainable
- flexible
- affordable
- ...

<div class="notes">
This is an open problem.

This is a continuous problem... always improving.

We need to consider many aspects to this problem.

Keep this as a laundry-list in the back of your mind when learning about new tools.
</div>

## Patterns

A common pattern for managing data

<div class="notes">
You see lots of data-centric solutions as a consultant.
</div>

## { data-background="images/classifying-with-state.svg" }


# Events
##

## Device Events
- location
- environment
- telemetry
- presence
- status (disk is full)
- ...
<div class="notes">
</div>

## User Events
- login
- checkout
- add friend
- ...
<div class="notes">
</div>

## Device Event
<pre><code>
{
  "time_utc": "1457741907.959400112",
  "device_id": "c361-445b-b2f6-27f2eecfc217",
  "event_type": "environmental_info",
  "degrees_fahrenheit": "72",
  ...
}
</code></pre>

<div class="notes">
there are device events
</div>

## User Event
<pre><code>
{
  "time_utc": "1457741907.959400112",
  "user_id": "688b60d1-c361-445b-b2f6-27f2eecfc217",
  "event_type": "login",
  ...
}
</code></pre>
<div class="notes">
we'll mostly focus on HCI events.

they can be simple...
</div>

## Flat User Event
<pre><code>
{
  "time_utc": "1457741907.959400112",
  "user_id": "688b60d1-c361-445b-b2f6-27f2eecfc217",
  "event_type": "button_pressed",
  "button_type": "one-click purchase",
  "item_sku": "1 23456 78999 9",
  "item_description": "Tony's Run-flat Tire",
  "item_unit_price": ...
  ...
}
</code></pre>
<div class="notes">
they can be more complex...
</div>

## Complex User Event
<pre><code>
{
  "time_utc": "1457741907.959400112",
  "user_id": "688b60d1-c361-445b-b2f6-27f2eecfc217",
  "event_type": "button_pressed",
  "event_details": {
    "button_type": "one-click purchase",
    "puchased_items": [
      {
        "sku": "1 23456 78999 9",
        "description": "Tony's Run-flat Tire",
        "unit_price": ...
        ...
      },
    ],
  },
  ...
}
</code></pre>
<div class="notes">
they can be downright ugly...

There are great formats and tools, but the state of the
art is pretty shoddy... adaptation/munging is often required
</div>

## Logs of Events

The _raw_ data is just streams of events

## { data-background="images/classifying-with-state.svg" }

<div class="notes">
pipe these streams of logs around
</div>


# Queries
##

## { data-background="images/classifying-with-state.svg" }

<div class="notes">
query data stores
</div>

## What do we need?

- 1
- 2

## Common approach

[ athena or bigquery exmple here ]


# Action
##

## { data-background="images/classifying-with-state.svg" }

<div class="notes">
take action from stream
</div>

## What do we need?

- 1
- 2

## Common approach

[ kafka ]
[ spark streaming or lambda exmple here ]


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



# Scratch

#
## Are our solutions:

- correct?
- tractable?
- stable?
- robust?
- reproducible?
- comprehensible?
- relevant?
- efficient?
- performant?

## Data Science

- correctness
- cardinality
- comparisons to external models
- invariants / symmetry
- intuition / geometry / wetware

## Engineering

- connectivity
- correctness
- performance

## Community

- pipeline patterns and tools
- failure modes
- sanity checks
- testing patterns in DS pipelines
- creative uses of simian army for data
- caching patterns in DS pipelines
- other places to steal ideas from?

