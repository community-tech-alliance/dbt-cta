{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ads_insights_platform_and_device_hashid'
) }}

-- SQL model to get latest `date_updated` values for each sid
-- depends_on: {{ ref('ads_insights_platform_and_device_ab4') }}

SELECT * FROM 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY _airbyte_ads_insights_platform_and_device_hashid ORDER BY updated_time desc) as rownum 
FROM {{ ref('ads_insights_platform_and_device_ab4') }}
)
where rownum=1