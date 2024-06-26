{{config(
    cluster_by="_cta_sync_datetime_utc",
    partition_by={"field": "_cta_sync_datetime_utc", "data_type": "timestamp", "granularity": "day"},
    unique_key="id"
)}}
    
-- Final base SQL model
        
SELECT * EXCEPT (rownum)
FROM {{ ref('tags_cte2') }}