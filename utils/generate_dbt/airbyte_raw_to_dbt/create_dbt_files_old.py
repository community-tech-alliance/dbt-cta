import os
import yaml
import helper_functions as helper

##### GENERATE CONTENTS OF DBT FILES

def _get_base_sql(
        table_schema_fields,
        concat_fields,
        table_id,
        partition_datetime_field,
        sync_mode
):
    sql = f"""
SELECT
    {table_schema_fields},
    FORMAT("%x", FARM_FINGERPRINT(CONCAT({concat_fields}))) AS _cta_hashid,
    CURRENT_TIMESTAMP() as _cta_sync_datetime_utc
FROM {{{{ source('cta', '{table_id}') }}}}
    
    """

    if sync_mode == 'full_refresh':
        sql += f"""{{% if is_incremental() %}}
where timestamp_trunc({partition_datetime_field}, day) in ({{{{ partitions_to_replace | join(",") }}}})
{{% endif %}}"""

        return sql

    elif sync_mode == 'incremental':

        return sql

    else:

        raise ValueError("Invalid sync mode (supported values: 'full_refresh', 'incremental')")


def _get_base_config(
        partition_datetime_field,
        unique_key,
        sync_mode
):
    if sync_mode == 'full_refresh':
        dbt_config = f"""
{{% set partitions_to_replace = [
    "timestamp_trunc(current_timestamp, day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)"
] %}}
    
{{{{config(
    cluster_by="_cta_sync_datetime_utc",
    partition_by={{"field": "{partition_datetime_field}", "data_type": "timestamp", "granularity": "day"}},
    partitions=partitions_to_replace,
    unique_key="{unique_key}"
)}}}}
    
        -- Final base SQL model
        """

        return dbt_config

    elif sync_mode == 'incremental':
        dbt_config = f"""
{{{{ config(
    cluster_by = "{partition_datetime_field}",
    partition_by = {{"field": "{partition_datetime_field}", "data_type": "timestamp", "granularity": "day"}},
    unique_key = '{unique_key}'
) }}}}

-- Final base SQL model
            """

        return dbt_config

    else:

        raise ValueError("Invalid sync mode (supported values: 'full_refresh', 'incremental')")
