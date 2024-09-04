{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_adsquads" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['auto_bid'], ['auto_bid']) }} as auto_bid,
    {{ json_extract_scalar('_airbyte_data', ['end_time'], ['end_time']) }} as end_time,
    {{ json_extract_scalar('_airbyte_data', ['placement'], ['placement']) }} as placement,
    {{ json_extract('table_alias', '_airbyte_data', ['targeting'], ['targeting']) }} as targeting,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['start_time'], ['start_time']) }} as start_time,
    {{ json_extract_scalar('_airbyte_data', ['target_bid'], ['target_bid']) }} as target_bid,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['campaign_id'], ['campaign_id']) }} as campaign_id,
    {{ json_extract_scalar('_airbyte_data', ['pacing_type'], ['pacing_type']) }} as pacing_type,
    {{ json_extract_scalar('_airbyte_data', ['bid_strategy'], ['bid_strategy']) }} as bid_strategy,
    {{ json_extract_scalar('_airbyte_data', ['billing_event'], ['billing_event']) }} as billing_event,
    {{ json_extract_scalar('_airbyte_data', ['child_ad_type'], ['child_ad_type']) }} as child_ad_type,
    {{ json_extract_scalar('_airbyte_data', ['creation_state'], ['creation_state']) }} as creation_state,
    {{ json_extract_array('_airbyte_data', ['delivery_status'], ['delivery_status']) }} as delivery_status,
    {{ json_extract_scalar('_airbyte_data', ['optimization_goal'], ['optimization_goal']) }} as optimization_goal,
    {{ json_extract_scalar('_airbyte_data', ['daily_budget_micro'], ['daily_budget_micro']) }} as daily_budget_micro,
    {{ json_extract_scalar('_airbyte_data', ['delivery_constraint'], ['delivery_constraint']) }} as delivery_constraint,
    {{ json_extract_scalar('_airbyte_data', ['forced_view_setting'], ['forced_view_setting']) }} as forced_view_setting,
    {{ json_extract_scalar('_airbyte_data', ['lifetime_budget_micro'], ['lifetime_budget_micro']) }} as lifetime_budget_micro,
    {{ json_extract('table_alias', '_airbyte_data', ['skadnetwork_properties'], ['skadnetwork_properties']) }} as skadnetwork_properties,
    {{ json_extract_scalar('_airbyte_data', ['targeting_reach_status'], ['targeting_reach_status']) }} as targeting_reach_status,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }} as table_alias
-- adsquads
where 1 = 1
{{ incremental_clause('_airbyte_extracted_at') }}

