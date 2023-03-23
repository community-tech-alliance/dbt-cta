{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_ad_set_report_hashid'
) }}

-- depends_on: {{ ref('ads_insights_overall_base') }}
with aggregations as (

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
from  {{ ref('ads_insights_overall_base') }}
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
    'account_id',
    'account_name',
    'campaign_id',
    'campaign_name',
    'adset_id',
    'adset_name'
    ]) }} as _ad_set_report_hashid
    ,current_timestamp as _airbyte_normalized_at
FROM aggregations