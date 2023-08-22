{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_uploads') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['key'], ['key']) }} as key,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['bucket'], ['bucket']) }} as bucket,
    {{ json_extract_scalar('_airbyte_data', ['counts'], ['counts']) }} as counts,
    {{ json_extract_scalar('_airbyte_data', ['result'], ['result']) }} as result,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['mappings'], ['mappings']) }} as mappings,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['campaign_id'], ['campaign_id']) }} as campaign_id,
    {{ json_extract_scalar('_airbyte_data', ['upload_type'], ['upload_type']) }} as upload_type,
    {{ json_extract_scalar('_airbyte_data', ['created_by_id'], ['created_by_id']) }} as created_by_id,
    {{ json_extract_scalar('_airbyte_data', ['entity_type_id'], ['entity_type_id']) }} as entity_type_id,
    {{ json_extract_scalar('_airbyte_data', ['visibility_status'], ['visibility_status']) }} as visibility_status,
    {{ json_extract_scalar('_airbyte_data', ['processing_options'], ['processing_options']) }} as processing_options,
    {{ json_extract_scalar('_airbyte_data', ['identification_field'], ['identification_field']) }} as identification_field,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_uploads') }}
-- uploads
where 1 = 1
