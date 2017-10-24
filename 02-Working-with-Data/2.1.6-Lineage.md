---
title: "Working With Data"
author: Data Lineage
...

---

## Format

- csv
- json
- avro
- ...

<div class="notes">
There're tons of file formats around

We'll go into more detail of lots of these formats later in the course

Focus for now on two common text-based formats: csv and json
</div>

## Format

- text (csv, tsv, json, xml, ...)
- binary (avro, parquet, xls, ...)

<div class="notes">
stored as json, excel etc
these are text formats, what else?
what about highly optimized queriable data formats like Avro or parquet? (columnar - column centric formats - binary data formats)</div>

## Format

[screencast exploring file formats from the command-line]

<div class="notes">
show `cat views.json | jq -C . | more`

show `cat views.xml | xmllint --format - | pygmentize -l xml | more`
</div>

#
## Schema / Types

[screencast on schema exploration from the command-line]

<div class="notes">
show screencast example using jq
</div>


#
## Data Count

[screencast on counting content from the command-line]

<div class="notes">
show screencast example using jq, grep, and wc
</div>


#
## Presence

[screencast on content exploration from the command-line]

<div class="notes">
show screencast example using jq and grep
</div>


#
## Data Ranges

[screencast on finding ranges of types from the command-line]

<div class="notes">
show screencast example using jq, grep, uniq, and sort

how does this differ for really large datasets?
</div>


#
## Data Lineage

[screencast on data lineage from the command-line]

<div class="notes">
what is the history of fields in this dataset?

dunno really what to show here
</div>


#
## Data Access

[screencast on accessing data from the command-line]

<div class="notes">
does it contain private data?

should access to this be restricted?

if so, how will users access this dataset?

this feeds directly into activity02
</div>


#

<img class="logo" src="images/berkeley-school-of-information-logo.png"/>


