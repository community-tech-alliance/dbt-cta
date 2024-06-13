{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_creatives') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('_airbyte_data', ['headline'], ['headline']) }} as headline,
    {{ json_extract_scalar('_airbyte_data', ['shareable'], ['shareable']) }} as shareable,
    {{ json_extract_scalar('_airbyte_data', ['ad_product'], ['ad_product']) }} as ad_product,
    {{ json_extract_scalar('_airbyte_data', ['brand_name'], ['brand_name']) }} as brand_name,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['render_type'], ['render_type']) }} as render_type,
    {{ json_extract_scalar('_airbyte_data', ['ad_account_id'], ['ad_account_id']) }} as ad_account_id,
    {{ json_extract_scalar('_airbyte_data', ['review_status'], ['review_status']) }} as review_status,
    {{ json_extract_scalar('_airbyte_data', ['call_to_action'], ['call_to_action']) }} as call_to_action,
    {{ json_extract_scalar('_airbyte_data', ['packaging_status'], ['packaging_status']) }} as packaging_status,
    {{ json_extract_scalar('_airbyte_data', ['top_snap_media_id'], ['top_snap_media_id']) }} as top_snap_media_id,
    {{ json_extract('table_alias', '_airbyte_data', ['web_view_properties'], ['web_view_properties']) }} as web_view_properties,
    {{ json_extract_scalar('_airbyte_data', ['review_status_details'], ['review_status_details']) }} as review_status_details,
    {{ json_extract_scalar('_airbyte_data', ['top_snap_crop_position'], ['top_snap_crop_position']) }} as top_snap_crop_position,
    {{ json_extract_scalar('_airbyte_data', ['forced_view_eligibility'], ['forced_view_eligibility']) }} as forced_view_eligibility,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_creatives') }} as table_alias
-- creatives
where 1 = 1
