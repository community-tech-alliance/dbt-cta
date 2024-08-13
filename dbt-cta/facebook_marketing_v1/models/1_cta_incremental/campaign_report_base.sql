{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_campaign_report_hashid'
) }}

-- depends_on: {{ ref('ads_insights_overall_base') }}

with aggregations as (

    select
        date_start,
        account_id,
        account_name,
        campaign_id,
        campaign_name,
        max(timestamp_trunc(_airbyte_emitted_at, day)) as _airbyte_emitted_at,
        sum(clicks) as clicks,
        sum(impressions) as impressions,
        sum(spend) as spend
    from {{ ref('ads_insights_overall_base') }}
    group by
        date_start,
        account_id,
        account_name,
        campaign_id,
        campaign_name
)

select
    *,
    {{ dbt_utils.surrogate_key([
    'date_start',
    'account_id',
    'account_name',
    'campaign_id',
    'campaign_name'
    ]) }} as _campaign_report_hashid,
    current_timestamp as _airbyte_normalized_at
from aggregations
