{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'ads') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
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
    json_extract_scalar(creative, "$.id") as creative_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'name',
    'status',
    'adset_id',
    'bid_type',
    'account_id',
    'bid_amount',
    'campaign_id',
    'created_time',
    'source_ad_id',
    'updated_time',
    'effective_status',
    'last_updated_by_app_id'
    ]) }} as _airbyte_ads_hashid
from {{ source('cta', 'ads') }}
