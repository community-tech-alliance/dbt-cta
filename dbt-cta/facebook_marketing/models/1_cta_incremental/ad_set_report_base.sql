{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_ad_set_report_hashid'
) }}

-- depends_on: {{ ref('ads_insights_overall_base') }}
with most_recent_only as (
SELECT * FROM 
    (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY adset_id, date_start ORDER BY _airbyte_emitted_at desc) as rownum 
    FROM {{ ref('ads_insights_overall_base') }}
    )
where rownum=1
),

aggregations as (

select
    date_start,
    account_id,
    account_name,
    campaign_id,
    campaign_name,
    adset_id,
    adset_name,
    timestamp_trunc(_airbyte_emitted_at, day) as _airbyte_emitted_at,
    sum(clicks) as clicks,
    sum(impressions) as impressions,
    sum(spend) as spend
from  most_recent_only
GROUP BY
    date_start,
    account_id,
    account_name,
    campaign_id,
    campaign_name,
    adset_id,
    adset_name,
    timestamp_trunc(_airbyte_emitted_at, day)
)

SELECT
    *,
    {{ dbt_utils.surrogate_key([
    'date_start',
    'adset_id',
    ]) }} as _ad_set_report_hashid
    ,current_timestamp as _airbyte_normalized_at
FROM aggregations
