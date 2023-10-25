{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_person_api_lookups_export') }}
select
    {{ json_extract_scalar('_airbyte_data', ['person_lookup_id'], ['person_lookup_id']) }} as person_lookup_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['exported_at'], ['exported_at']) }} as exported_at,
    {{ json_extract_scalar('_airbyte_data', ['api_match_id'], ['api_match_id']) }} as api_match_id,
    {{ json_extract_scalar('_airbyte_data', ['api_username'], ['api_username']) }} as api_username,
    {{ json_extract_scalar('_airbyte_data', ['person_lookup_type'], ['person_lookup_type']) }} as person_lookup_type,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['api_key'], ['api_key']) }} as api_key,
    {{ json_extract_scalar('_airbyte_data', ['api_type'], ['api_type']) }} as api_type,
    {{ json_extract_scalar('_airbyte_data', ['success'], ['success']) }} as success,
    {{ json_extract_scalar('_airbyte_data', ['van_database_mode'], ['van_database_mode']) }} as van_database_mode,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['campaign_id'], ['campaign_id']) }} as campaign_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_person_api_lookups_export') }} as table_alias
-- person_api_lookups_export
where 1 = 1

