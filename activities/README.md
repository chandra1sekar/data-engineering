
# Synthesis of Basics Project
## Identify the most popular commute
- what's a commute (ie session)
- what communtes don't count ()
- how to count commutes
- how to write queries


### set up google cloud account, look at bike data
  * set up account (https://cloud.google.com/)
  * through console, pretty straightforward (https://bigquery.cloud.google.com/table/bigquery-public-data:san_francisco.bikeshare_trips?pli=1)
  *break down json view into original atomic events (brainstorm)
  *To make business decisions, we want to know the scope of the dataset
  *queries:
  
  What's the size of this dataset? (i.e., how many trips) How big is this spreadsheet - 983K rows?
    SELECT count(*)
    FROM [bigquery-public-data:san_francisco.bikeshare_trips]
  
  What is the earliest start time and latest end time (in `start_date`)
    SELECT min(start_date)
    FROM [bigquery-public-data:san_francisco.bikeshare_trips]

    SELECT max(end_date)
    FROM [bigquery-public-data:san_francisco.bikeshare_trips]

  How many bikes are there? 700
  SELECT count(distinct bike_number)
  FROM [bigquery-public-data:san_francisco.bikeshare_trips]

  How many stations are there? Well, we have start_station_id (74), start_station_name (84), end_station_id (74), end_station_name (84), are they the same? (repeat query for each). 
  
  SELECT count(distinct start_station_id)
  FROM [bigquery-public-data:san_francisco.bikeshare_trips]

  Notice: not all SQL is the same - e.g., SELECT distinct <variable> doesn't work in BQ
  Why is it different betweenstation names and ids? 
  First figure out 'by hand' where the diffs are:
  SELECT end_station_name, end_station_id
  FROM [bigquery-public-data:san_francisco.bikeshare_trips]
  GROUP BY end_station_name, end_station_id
  ORDER BY end_station_id

  Next in one query:
  TODO: write query that figures out the weird ones in one query

Next, some real quetsions
How many trips in am vs pm?
Build up questions: 
la
la
la

Final questions: 
What are the 10 most popular trips?
Has that changed over time?

Spreadsheet, google docs, to demo/show graphs/report results
We're querying 1M line dataset, do histogram plots of data. 
Go export that to your csv that you want (lol).
Concept in M's head :) We have this raw dataset, doing some queries, copying results out (json, csv, gsheet), we're graphing those, ...
Can render hist in notebook ...
Or start actually running models and doing analysis, more sophisticated things...
We want to start getting our analysis tools to the data itself, not copying data around.

### look at BQ bike data from cli
  * set up Google cloud SDK
  * set up project
  * bq, gsutil, gcloud
  * how to do sql from cli here?
  General example:
  bq query --use_legacy_sql=false '
SELECT
  EXTRACT(YEAR FROM start_date) AS year,
  ROUND(AVG(duration_sec/60), 2) AS avg_duration_min,
  COUNT(*) AS yearly_trips
FROM
  `bigquery-public-data.san_francisco.bikeshare_trips`
GROUP BY
  YEAR
ORDER BY
  YEAR DESC'

### repeat in athena (both clicky box and cli)
(write their own queries this round)

### look at BQ bike data from notebooks


# Deep Learning (image rec)
##http://deeplearning.net/datasets/
-python
-docker
-model dev/training (canned model?)
-more cli
-data sources

# Recommender Project
##https://github.com/fluxcapacitor/pipeline/blob/master/zeppelin/Dockerfile
-for example
