{{
    config(
        cluster_by="updated_at",
        partition_by={
            "field": "updated_at",
            "data_type": "updated_at",
            "granularity": "day",
        },
        unique_key="_daily_surveys_hashid",
        on_schema_change="add"
    )
}}

select *
from {{ ref('daily_surveys_cte2') }}