# Thrutext

This is a special snowflake because ThruText exports contain custom fields that are defined for each GetThru customer. For that reason, the dbt incrementally updates base tables using a combination of `SELECT *` and the config `on_schema_change: add`, which should cause schema changes to result in new columns being added. We won't really test this until/unless schemas actually change, though.

## In the event of a schema change

The DAG and this dbt will still succeed, but the partner will probably let us know that they need a new field(s) to be added. If we need to change/add those fields:

1 - update the schema JSON (this is in the repo with the Airflow DAG)
2 - trigger the DAG with `refresh_matviews: True` to refresh the matviews so that they reflect the updated schema.
