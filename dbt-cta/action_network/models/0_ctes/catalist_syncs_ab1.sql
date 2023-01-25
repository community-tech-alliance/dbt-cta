{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_catalist_syncs') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['token'], ['token']) }} as token,
    {{ json_extract_scalar('_airbyte_data', ['active'], ['active']) }} as active,
    {{ json_extract_scalar('_airbyte_data', ['client_id'], ['client_id']) }} as client_id,
    {{ json_extract_scalar('_airbyte_data', ['source_id'], ['source_id']) }} as source_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['dwid_field'], ['dwid_field']) }} as dwid_field,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['catalist_id'], ['catalist_id']) }} as catalist_id,
    {{ json_extract_scalar('_airbyte_data', ['source_type'], ['source_type']) }} as source_type,
    {{ json_extract_scalar('_airbyte_data', ['client_secret'], ['client_secret']) }} as client_secret,
    {{ json_extract_scalar('_airbyte_data', ['token_expires_in'], ['token_expires_in']) }} as token_expires_in,
    {{ json_extract_scalar('_airbyte_data', ['token_updated_at'], ['token_updated_at']) }} as token_updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_catalist_syncs') }} as table_alias
-- catalist_syncs
where 1 = 1

