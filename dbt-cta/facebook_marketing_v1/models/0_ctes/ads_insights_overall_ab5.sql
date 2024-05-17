{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ads_insights_overall_hashid'
) }}


SELECT * EXCEPT (rownum) FROM 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY _airbyte_ads_insights_overall_hashid ORDER BY _airbyte_emitted_at desc) as rownum 
from {{ ref('ads_insights_overall_ab4') }}
)
where rownum=1