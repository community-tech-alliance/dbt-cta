# Summary

This dbt uses raw data delivered by our (shiny new) Hustle S3-to-BQ sync and delivers the data to partners via materialized views with rows deduped by a primary key (or hashid where no PK exists).

## Row deduplication

Deduping happens in `*_cte2` for each table. This ensures that only one row exists for each primary key value based on whichever one is most recent (based on `updated_at` where possible, or `_cta_sync_datetime_utc` otherwise).

## Incremental strategy

The source data update incrementally, so all base table models use `1_cta_incremental`, merging in new rows based on the unique key (usually `id`, sometimes `_cta_hashid`, see below).

## Format

All models for the Hustle sync use a consistent format, with two possible variations:

- tables with no `id` dedupe using `_cta_hashid` as the primary key, which is generated as a hash of all columns in the table (except for `_cta_sync_datetime_utc`, which is added in `*_cte1`)
- tables with no `updated_at` dedupe using `_cta_sync_datetime_utc` as the field for identifying the most recent row of data for each primary key.
- (both of the above might be true for a table, which would then dedupe using the most recent `_cta_sync_datetime_utc` for each `_cta_hashid`)