{{
    config(
        cluster_by="timestamp",
        partition_by={
            "field": "timestamp",
            "data_type": "timestamp",
            "granularity": "day",
        },
        unique_key="_daily_messages_hashid",
        on_schema_change="append_new_columns"
    )
}}

select *
from {{ ref('daily_messages_cte2') }}
