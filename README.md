# Coffee Rewards - End-to-End Data Analytics Project

An end-to-end analysis of a coffee loyalty rewards program: 17,000 customers,
306,000+ tracked events, and 10 promotional offers. The project covers the
full pipeline from raw data to business-ready insights, in two parallel
implementations.

## What's here

**SQL + Python + Tableau** (original)
- Coffee_rewards SQL.sql - core analysis queries: offer performance,
  customer segmentation by age and income, high-value customer ranking
- Coffee Rewards Python.ipynb - feature engineering and exploratory
  analysis in Pandas
- Coffee_Rewards.db - SQLite database backing the analysis
- Tableau dashboard: [link here]

**dbt + BigQuery** (dbt/)
- The same transformation logic rebuilt as a tested, documented dbt
  project running on Google BigQuery
- See dbt/README.md for the pipeline, lineage graph, and a real bug
  found and fixed during the migration
- Includes 6 passing dbt data quality tests

## Key findings

- Discount-type offers had the highest completion rate (60.9%) among the
  three offer types tested
- Top-spending customers accounted for a disproportionate share of total
  revenue, identified via a spend-ranked customer view
- Average transaction value varied meaningfully by age group, informing
  which segments respond best to which offer types

## Tech stack

SQL (SQLite, BigQuery), Python (Pandas), dbt, Tableau

## Structure

Coffee_rewards SQL.sql, Coffee Rewards Python.ipynb, Coffee_Rewards.db,
and the Data/ folder hold the original SQL/Python/Tableau analysis.
The dbt/ folder holds the dbt on BigQuery rebuild - see dbt/README.md.
