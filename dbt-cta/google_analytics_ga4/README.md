# GA4

This dbt was generated with our generate_dbt.py helper script (see the `utils/` folder), which assumes the Airbyte connection is using BigQuery Destination V2, which automatically delivers normalized tables to the CTA project used for creating base tables that are ultimately synced to partner projects.

Thus, all the dbt is doing for this sync is to start with the normalized tables (listed in sources.yml) and perform light transformations to:

- calculate a hashid based on all non-JSON columns in the normalized data, which will serve as a unique row identifier, and
- remove `_airbyte_raw_id` from the final models.