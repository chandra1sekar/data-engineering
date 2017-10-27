---
title: "Querying Data"
author: DataFrames in Notebooks
...

---

# Jupyter Notebooks

# 
## Sample Dataset

Web Logs

## 

![](images/webserver.png)

##

<img height="500px" src="images/loadbalancer.png"/>


#
## Data Exploration

## Summarize

    select * from "sampledb"."elb_logs" limit 10;

## Count

    select count(*) from "sampledb"."elb_logs";

## Date range

    select min(request_timestamp), max(request_timestamp)
        from "sampledb"."elb_logs";

## Count clicks

    select count(*)
        from "sampledb"."elb_logs"
        where url = 'https://www.example.com/jobs/819';

## Count distinct users

    select count(distinct request_ip)
        from "sampledb"."elb_logs"
        where url = 'https://www.example.com/jobs/819';

## Count distinct mac users

    select count(distinct request_ip)
        from "sampledb"."elb_logs"
        where url = 'https://www.example.com/jobs/819'
        and user_agent like '%Macintosh%';

## Are there any broken balancers?

    select elb_name, count(*)
        from "sampledb"."elb_logs"
        where elb_response_code = '500'
        group by (elb_name)
        order by (elb_name);


#
## How well does a Pandas DataFrame

- perform?
- scale?
- handle change?


#
## More Info



#

<img class="logo" src="images/berkeley-school-of-information-logo.png"/>


