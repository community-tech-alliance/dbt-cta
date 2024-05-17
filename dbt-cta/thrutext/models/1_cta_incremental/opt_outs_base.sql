{{
    config(
        cluster_by="timestamp",
        partition_by={
            "field": "timestamp",
            "data_type": "timestamp",
            "granularity": "day",
        },
        unique_key="_opt_outs_hashid",
        on_schema_change="add"
    )
}}

select *
from {{ ref('opt_outs_cte2') }}
