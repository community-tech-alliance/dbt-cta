# Spoke (Rewired flavor)

This sync is a special snowflake because it runs in a DAG designed for syncing large Postgres tables to BigQuery. (Airbyte has a Postgres source connector, but it doesn't work very well when syncing large amounts of data.)

For that reason, `0_ctes` (a model present in most other vendor syncs) is absent from this project, since the "raw" data the sync delivers to BigQuery are already flattened and the data typed appropriately (which are most of what the CTEs in other models are accomplishing).

### Possible TODO(): 

We could add a CTE model to calculate a hashid to uniquely identify rows if we want to use them for deduplicating rows in the partner materialized views. This could be useful for large tables synced incrementally, just to explicitly dedupe the final data objects. (But in theory that should not be necessary.)