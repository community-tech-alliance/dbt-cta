{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_tag_categories') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('_airbyte_data', ['locked'], ['locked']) }} as locked,
    {{ json_extract_scalar('_airbyte_data', ['target_id'], ['target_id']) }} as target_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['created_by'], ['created_by']) }} as created_by,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['target_type'], ['target_type']) }} as target_type,
    {{ json_extract_scalar('_airbyte_data', ['tag_group_id'], ['tag_group_id']) }} as tag_group_id,
    {{ json_extract_scalar('_airbyte_data', ['multiselectable'], ['multiselectable']) }} as multiselectable,
    {{ json_extract_scalar('_airbyte_data', ['read_only_category'], ['read_only_category']) }} as read_only_category,
    {{ json_extract_scalar('_airbyte_data', ['allow_create_tag_type'], ['allow_create_tag_type']) }} as allow_create_tag_type,
    {{ json_extract_scalar('_airbyte_data', ['multiselect_same_tag_behavior'], ['multiselect_same_tag_behavior']) }} as multiselect_same_tag_behavior,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_tag_categories') }} as table_alias
-- tag_categories
where 1 = 1

