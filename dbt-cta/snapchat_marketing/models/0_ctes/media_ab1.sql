{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_media') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['hash'], ['hash']) }} as {{ adapter.quote('hash') }},
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('_airbyte_data', ['file_name'], ['file_name']) }} as file_name,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['visibility'], ['visibility']) }} as visibility,
    {{ json_extract_scalar('_airbyte_data', ['media_status'], ['media_status']) }} as media_status,
    {{ json_extract_scalar('_airbyte_data', ['ad_account_id'], ['ad_account_id']) }} as ad_account_id,
    {{ json_extract_scalar('_airbyte_data', ['download_link'], ['download_link']) }} as download_link,
    {{ json_extract_scalar('_airbyte_data', ['is_demo_media'], ['is_demo_media']) }} as is_demo_media,
    {{ json_extract('table_alias', '_airbyte_data', ['image_metadata'], ['image_metadata']) }} as image_metadata,
    {{ json_extract('table_alias', '_airbyte_data', ['video_metadata'], ['video_metadata']) }} as video_metadata,
    {{ json_extract_scalar('_airbyte_data', ['file_size_in_bytes'], ['file_size_in_bytes']) }} as file_size_in_bytes,
    {{ json_extract_scalar('_airbyte_data', ['duration_in_seconds'], ['duration_in_seconds']) }} as duration_in_seconds,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_media') }} as table_alias
-- media
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

