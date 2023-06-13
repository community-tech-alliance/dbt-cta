{{config(
    cluster_by="_cta_sync_datetime_utc",
    partition_by={"field": "_cta_sync_datetime_utc", "data_type": "timestamp", "granularity": "day"},
    unique_key="_cta_hashid"
)}}
    
-- Final base SQL model
        
SELECT
    *
FROM {{ ref('group_memberships_cte2') }}