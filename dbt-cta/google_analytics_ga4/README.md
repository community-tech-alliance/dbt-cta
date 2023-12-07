# GA4

This dbt assumes the Airbyte connection is using BigQuery Destination V2, which automatically delivers normalized tables to the CTA project used for creating base tables that are ultimately synced to partner projects.

Thus, all the dbt is doing for syncs like this is to start with the normalized tables (listed in sources.yml) and perform light transformations to:

- remove unwanted columns (namely `_airbyte_raw_id` and `_airbyte_meta`)
- cast fields to data types, if something is desired other than Airbyte's default behavior (usually not needed)
- rename any columns (usually not needed)