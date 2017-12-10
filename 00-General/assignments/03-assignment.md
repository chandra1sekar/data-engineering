### look at BQ bike data from cli
  - set up Google cloud SDK
  - set up project
  - bq, gsutil, gcloud
  - how to do sql from cli here?

  https://cloud.google.com/bigquery/bq-command-line-tool

# Query Project Part II
## Assignment 03: Querying data from the BigQuery command line

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

