{{
    config(
        cluster_by="timestamp",
        partition_by={
            "field": "timestamp",
            "data_type": "timestamp",
            "granularity": "day",
        },
        unique_key="_daily_surveys_hashid",
    )
}}

select
    *
from {{ ref('daily_surveys_cte2') }}
