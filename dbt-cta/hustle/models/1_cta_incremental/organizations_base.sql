{{ config(
    cluster_by="_cta_sync_datetime_utc",
    partition_by={"field": "_cta_sync_datetime_utc", "data_type": "timestamp", "granularity": "day"},
    unique_key="id"
) }}

-- Final base SQL model

select * except (rownum)
from {{ ref('organizations_cte2') }}
