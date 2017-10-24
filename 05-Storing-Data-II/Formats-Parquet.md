---
title: "File Formats"
author: "Parquet"
...

---

#
## Agenda { data-background="images/watch-faded.png" }

- What is Parquet?
- How do we use it?
- What does it actually look like?
- Are there tools to help?
- More info


#
## Parquet

- column-centric storage on disk
- fast to read... it's opimized for queries
- writing can be complicated... append-only
- self-describing, evolving schema


#
## Parquet

- supports nested schema
- supports various layers of compression
- language-independent
- ubiquitous... builtin part of the hadoop ecosystem


#
## Parquet

- optimized for:
    - column-based aggregations
    - data at rest
- not optimized for:
    - `select *` (row-based)
    - inserts/updates (entire dataset needs re-encoding)


#
##
![](images/columnar.png)


#
## Explore

- column chunks
- footer has offsets
- footer has schema


# 
## Tooling

- hadoop filesystem tools
- spark
- language-specific


#
## More Info

- [directly from the src](https://github.com/apache/parquet-format)

- [spark notebook example](https://docs.databricks.com/spark/latest/data-sources/read-parquet.html)

- [choosing a data format](http://markmims.com/)

- [racing different data formats](http://markmims.com/)

- [cool-slides](https://www.slideshare.net/larsgeorge/parquet-data-io-philadelphia-2013)

- [dremel storage algorithms](https://github.com/julienledem/redelm/wiki/The-striping-and-assembly-algorithms-from-the-Dremel-paper)


#

<img class="logo" src="images/berkeley-school-of-information-logo.png"/>
