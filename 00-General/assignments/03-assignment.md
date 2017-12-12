# Query Project
- In the Query Project, you will get practice with SQL while learning about Google Cloud Platform (GCP) and BiqQuery. You'll answer business-driven questions using public datasets housed in GCP. To give you experience with all the ways to use those datasets, you will use the web UIs (BiqQuery), the command-line tools, and make calls to the BigQuery REST API using the client libraries for Python through jupyter notebooks.
- We will be using the Bay Area Bike Share Trips Data (https://cloud.google.com/bigquery/public-data/bay-bike-share). 
- You're a data scientist at Ford GoBike (https://www.fordgobike.com/), the company running Bay Area Bikeshare. You are trying to increase ridership, and you want to offer deals through the mobile app to do so. What deals do you offer though? Currently, your company has three options: a flat price for a single one-way trip, a day pass that allows unlimited 30-minute rides for 24 hours and an annual membership. 

Through this project, you will answer these questions: 
What are the 5 most popular trips that you would call "commuter trips"?
What are the 5 most popular trips that you would call "recreational trips"?

What are your recommendations for offers (justify based on your findings)?

### look at BQ bike data from cli
  - set up Google cloud SDK
  - set up project
  - bq, gsutil, gcloud
  - how to do sql from cli here?

  https://cloud.google.com/bigquery/bq-command-line-tool

## Assignment 03 - Querying data from the BigQuery CLI - set up (Query Project)

### What is Google Cloud SDK?
- Read: https://cloud.google.com/sdk

https://cloud.google.com/sdk/docs/

### Get Going
- AFAIK, YOU CAN'T DO ANYTHING FROM THE CLI WITHOUT SETTING UP A PROJECT TO BE DOING IT IN
  * Get instructions in here for how to set up a project

- Install Google Cloud SDK https://cloud.google.com/sdk/docs/
- Try BQ from the command line:
  * General query structure

    bq query --use_legacy_sql=false '
        SELECT count(*)
        FROM
           `bigquery-public-data.san_francisco.bikeshare_trips`'


### Queries

- How many stations are there?

- How many trips are in the morning vs in the afternoon?

