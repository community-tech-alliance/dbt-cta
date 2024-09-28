{{
    config(
        cluster_by="loaded_at",
        partition_by={
            "field": "loaded_at",
            "data_type": "timestamp",
            "granularity": "day",
        },
        unique_key="_daily_messages_hashid",
        on_schema_change="sync_all_columns"
    )
}}

select *
from {{ ref('daily_messages_cte2') }}
