# Coffee Rewards - dbt on BigQuery

A dbt project rebuilding the transformation layer of the Coffee Rewards
analysis on BigQuery, replacing the original ad hoc SQLite queries with
tested, documented, version-controlled data models.

## Pipeline

Raw seeds (customers, events, offers) feed into stg_events.sql, which
parses the raw JSON-like event log into clean offer_id, amount, and
reward columns. That feeds into fct_customer_summary.sql, which produces
one row per customer with total spend, total rewards, and a spend rank.

## Notable fix

The original SQLite version parsed the reward field using manual
substring offset math. For single-digit rewards this produced malformed
values like "5}" - SQLite's lenient CAST() silently truncated the
garbage and returned 5.0, masking the bug. BigQuery's stricter CAST()
rejected these rows outright, surfacing the issue. Fixed by rewriting
the parsing logic with REGEXP_EXTRACT, which is both more robust and
easier to read than the original offset math.

## Tests

Six dbt tests run across the staging and mart layers: not_null and
unique on primary keys, plus accepted_values on the event type column.
All currently passing.

## Stack

dbt-core, dbt-bigquery, Google BigQuery (free tier)
