---
title: Fundamentals of Data Engineering
author: Week 03 - sync session
...

---

- go through how to get cli running to prep for week's activities

- generate ideas (what do you know? what will you need to find out) for your questions for ## Questions
- Through this project, you will answer these questions: 
  * What are the 5 most popular trips that you would call "commuter trips"?
  * What are your recommendations for offers (justify based on your findings)?

- work on bq cli (using docker)
- More complex queries

- jq & cli activities to unwind data and find out stuff

# 

## Assignment 2

## What was your coolest query?

- take a minute, be ready to present

::: notes
breakout
:::


## What's the size of this dataset? (i.e., how many trips)

`983648`
 

    #standardSQL
    SELECT count(*) FROM `bigquery-public-data.san_francisco.bikeshare_trips`


## What is the earliest start time and latest end time for a trip?

`2013-08-29 09:08:00` 
`2016-08-31 23:48:00`


    #standardSQL
    SELECT min(start_date) 
    FROM `bigquery-public-data.san_francisco.bikeshare_trips`

    #standardSQL
    SELECT max(end_date) 
    FROM `bigquery-public-data.san_francisco.bikeshare_trips`

## How many bikes are there?

`700`

    #standardSQL
    SELECT count(distinct bike_number)
    FROM `bigquery-public-data.san_francisco.bikeshare_trips`



## Due Friday (PR)

## Housekeeping

- Channel etiquette

# 

## Activities: async content

## 

- You got started with lots of stuff this week
- Working with files: json, csv etc

## Finding stuff out about your data

## Download Datasets

Save into your `~/w205` directory

::: notes
make sure they go into `~/w205`
:::

## Start a container
```
docker run -it --rm -v ~/w205:/w205 midsw205/base bash
```

::: notes
- the volume option works as-is on mac/linux, but might need to be adjusted
  for windows depending on which shell they're using
- can also run this from a student droplet if students are still having docker
  issues
:::

## What's in this file?

`head lp_data.csv`

`tail lp_data.csv`

::: notes
WHERE DO DATASETS GO?

- Lots of csvs and tsvs I get sent/access to have e.g., 17M rows
- I don't want to have to open that or `cat` it or even `| less`
:::

## What are variables in here?

`head -n1 lp_data.csv`

::: notes

- These are the columns in the dataset
- business_id,date,review_id,stars,text,type,user_id,cool,useful,funny

:::

## How many entries?

`cat lp_data.csv | wc -l`

::: notes

- 100 rows
:::

## How about sorting?

`cat lp_data.csv | sort`

::: notes

- it sorts by usage
- but it's treating numbers weird
:::

## Take a look at what options there are for sort

`man sort`

::: notes

- Ask them to generate options

    -g, --general-numeric-sort
    compare according to general numerical value

     -n, --numeric-sort
    compare according to string numerical value
:::


## fix so sorting correctly

`cat lp_data.csv | sort -g`

`cat lp_data.csv | sort -n`


# 

## Find out which topics are more popular

## What have we got in this file?

`head annot_fpid.json`

::: notes

- It will scroll all over the page, 
- b/c it's json, it's just one line, so head is everything
:::

## Hmmm, what now? jq

pretty print the json


`cat annot_fpid.json | jq .`

::: notes

- There's a slide for a jq reference at the end here, we're just going to do a little in class
:::

## Just the terms

`cat annot_fpid.json | jq '.[][]'`

::: notes

- 
:::

## Remove the ""s

`cat annot_fpid.json | jq '.[][]' -r`

::: notes

- 
:::

## Can we sort that?

`cat annot_fpid.json | jq '.[][]' -r | sort `

::: notes

- Hmmm, there's lots of repeated terms
:::

## Unique values only

    cat annot_fpid.json | jq '.[][]' -r | 
    sort | uniq 

::: notes

- 
:::

## How could I find out how many of each of those unique values there are?

    cat annot_fpid.json | jq '.[][]' -r | 
    sort | uniq -c 

::: notes

- 
:::

## Now, how could I sort by that?


    cat annot_fpid.json | jq '.[][]' -r | 
    sort | uniq -c | sort -g

Ascending

    cat annot_fpid.json | jq '.[][]' -r | 
    sort | uniq -c | sort -gr

Descending

::: notes

- 
:::

## So, what are the top ten terms?

    cat annot_fpid.json | jq '.[][]' -r | 
    sort | uniq -c | sort -gr | head -10


::: notes

- 
:::

#

## bq cli

## setup

(from your mids container)

- auth the GCP client
  ```
  gcloud init
  ```
  and copy/paste the link

- associate `bq` with a project
  ```
  bq
  ```
  and select project if asked

::: notes
- The `gcloud` and `bq` cli tools are already installed in the `midsw205/base`
  docker image
- `gcloud init` will print an oauth link that needs to be copied over to a browser
:::

##

    bq query --use_legacy_sql=false '
    SELECT count(*)
    FROM `bigquery-public-data.san_francisco.bikeshare_status`'



::: notes
107,501,619

The point: you can use `select *` to actually answer questions.
:::

## How many stations are there?

##

    bq query --use_legacy_sql=false '
    SELECT count(distinct station_id)
    FROM `bigquery-public-data.san_francisco.bikeshare_status`'

::: notes
The point: how to count unique
Answer: something like 75
:::


## How long a time period do these data cover?

##

    bq query --use_legacy_sql=false '
    SELECT min(time), max(time)
    FROM `bigquery-public-data.san_francisco.bikeshare_status`'


::: notes
- 2013-08-29 12:06:01.000 UTC   
- 2016-08-31 23:58:59.000 UTC   
:::


#
## Generate Ideas

- What do you know?
- What will you need to find out?

::: notes

- breakout
- get them going on questions for project like:
  * What's a trip?
  * What's a commuter trip?
  * etc
:::

# Big Ideas: New Topic
# Introduce/Revisit Project & this week's assignment on New Topic
# Activities: New Topic
# Wrap Up
## Summary

#
## Extras

## Resources

## sed and awk

http://www.catonmat.net/blog/awk-one-liners-explained-part-one/
http://www.catonmat.net/blog/sed-one-liners-explained-part-one/

## jq

https://stedolan.github.io/jq/tutorial/

## Advanced options 

## Sort by 'product_name'

`cat lp_data.csv | awk -F',' '{ print $2,$1 }' | sort`

::: notes

- Put in extras for add ons or activities if folks finish early

- This switches the columns and sorts on LP title
- but you find out that some LPs have ""s around the titles
:::


## Fix the ""s issue

`cat lp_data.csv  | awk -F',' '{ print $2,$1 }' | sed 's/"//' | sort | less`

::: notes

- the sed part here takes out the "" 
- and then we sort based on title
:::

## 

`command`

::: notes

- lala
:::



#

<img class="logo" src="images/berkeley-school-of-information-logo.png"/>

