{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_ads') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_array('_airbyte_data', ['adlabels'], ['adlabels']) }} as adlabels,
    {{ json_extract_scalar('_airbyte_data', ['adset_id'], ['adset_id']) }} as adset_id,
    {{ json_extract('table_alias', '_airbyte_data', ['bid_info'], ['bid_info']) }} as bid_info,
    {{ json_extract_scalar('_airbyte_data', ['bid_type'], ['bid_type']) }} as bid_type,
    {{ json_extract('table_alias', '_airbyte_data', ['creative'], ['creative']) }} as creative,
    {{ json_extract('table_alias', '_airbyte_data', ['targeting'], ['targeting']) }} as targeting,
    {{ json_extract_scalar('_airbyte_data', ['account_id'], ['account_id']) }} as account_id,
    {{ json_extract_scalar('_airbyte_data', ['bid_amount'], ['bid_amount']) }} as bid_amount,
    {{ json_extract_scalar('_airbyte_data', ['campaign_id'], ['campaign_id']) }} as campaign_id,
    {{ json_extract_scalar('_airbyte_data', ['created_time'], ['created_time']) }} as created_time,
    {{ json_extract_scalar('_airbyte_data', ['source_ad_id'], ['source_ad_id']) }} as source_ad_id,
    {{ json_extract_scalar('_airbyte_data', ['updated_time'], ['updated_time']) }} as updated_time,
    {{ json_extract_array('_airbyte_data', ['tracking_specs'], ['tracking_specs']) }} as tracking_specs,
    {{ json_extract_array('_airbyte_data', ['recommendations'], ['recommendations']) }} as recommendations,
    {{ json_extract_array('_airbyte_data', ['conversion_specs'], ['conversion_specs']) }} as conversion_specs,
    {{ json_extract_scalar('_airbyte_data', ['effective_status'], ['effective_status']) }} as effective_status,
    {{ json_extract_scalar('_airbyte_data', ['last_updated_by_app_id'], ['last_updated_by_app_id']) }} as last_updated_by_app_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_ads') }} as table_alias
-- ads
where 1 = 1

