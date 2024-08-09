{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_ads" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: { source('cta_raw', raw_table) }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['ad_squad_id'], ['ad_squad_id']) }} as ad_squad_id,
    {{ json_extract_scalar('_airbyte_data', ['creative_id'], ['creative_id']) }} as creative_id,
    {{ json_extract_scalar('_airbyte_data', ['render_type'], ['render_type']) }} as render_type,
    {{ json_extract_scalar('_airbyte_data', ['review_status'], ['review_status']) }} as review_status,
    {{ json_extract_array('_airbyte_data', ['delivery_status'], ['delivery_status']) }} as delivery_status,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from { source('cta_raw', raw_table) }} as table_alias
-- ads
where 1 = 1
{{ incremental_clause('_airbyte_extracted_at') }}

