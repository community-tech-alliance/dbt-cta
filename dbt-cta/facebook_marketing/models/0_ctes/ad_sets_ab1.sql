{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_ad_sets') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_array('_airbyte_data', ['adlabels'], ['adlabels']) }} as adlabels,
    {{ json_extract('table_alias', '_airbyte_data', ['bid_info'], ['bid_info']) }} as bid_info,
    {{ json_extract_scalar('_airbyte_data', ['end_time'], ['end_time']) }} as end_time,
    {{ json_extract('table_alias', '_airbyte_data', ['targeting'], ['targeting']) }} as targeting,
    {{ json_extract_scalar('_airbyte_data', ['account_id'], ['account_id']) }} as account_id,
    {{ json_extract_scalar('_airbyte_data', ['start_time'], ['start_time']) }} as start_time,
    {{ json_extract_scalar('_airbyte_data', ['campaign_id'], ['campaign_id']) }} as campaign_id,
    {{ json_extract_scalar('_airbyte_data', ['created_time'], ['created_time']) }} as created_time,
    {{ json_extract_scalar('_airbyte_data', ['daily_budget'], ['daily_budget']) }} as daily_budget,
    {{ json_extract_scalar('_airbyte_data', ['updated_time'], ['updated_time']) }} as updated_time,
    {{ json_extract_scalar('_airbyte_data', ['lifetime_budget'], ['lifetime_budget']) }} as lifetime_budget,
    {{ json_extract('table_alias', '_airbyte_data', ['promoted_object'], ['promoted_object']) }} as promoted_object,
    {{ json_extract_scalar('_airbyte_data', ['budget_remaining'], ['budget_remaining']) }} as budget_remaining,
    {{ json_extract_scalar('_airbyte_data', ['effective_status'], ['effective_status']) }} as effective_status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_ad_sets') }} as table_alias
-- ad_sets
where 1 = 1
