{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}

-- depends_on: {{ ref('ads_ab2') }}
select
    id,
    _airbyte_extracted_at,
    _airbyte_raw_id,
    name,
    status,
    adlabels,
    adset_id,
    bid_info,
    bid_type,
    creative,
    targeting,
    account_id,
    bid_amount,
    campaign_id,
    created_time,
    source_ad_id,
    updated_time,
    tracking_specs,
    recommendations,
    conversion_specs,
    effective_status,
    last_updated_by_app_id,
    json_extract_scalar(creative, "$.id") as creative_id
from {{ ref('ads_ab2') }}
