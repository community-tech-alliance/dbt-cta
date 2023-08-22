{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_entity_types') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['icon'], ['icon']) }} as icon,
    {{ json_extract_scalar('_airbyte_data', ['name_type'], ['name_type']) }} as name_type,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['interact_id'], ['interact_id']) }} as interact_id,
    {{ json_extract_scalar('_airbyte_data', ['name_plural'], ['name_plural']) }} as name_plural,
    {{ json_extract_scalar('_airbyte_data', ['email_enabled'], ['email_enabled']) }} as email_enabled,
    {{ json_extract_scalar('_airbyte_data', ['name_singular'], ['name_singular']) }} as name_singular,
    {{ json_extract_scalar('_airbyte_data', ['social_enabled'], ['social_enabled']) }} as social_enabled,
    {{ json_extract_scalar('_airbyte_data', ['address_enabled'], ['address_enabled']) }} as address_enabled,
    {{ json_extract_scalar('_airbyte_data', ['language_enabled'], ['language_enabled']) }} as language_enabled,
    {{ json_extract_scalar('_airbyte_data', ['phone_number_enabled'], ['phone_number_enabled']) }} as phone_number_enabled,
    {{ json_extract_scalar('_airbyte_data', ['date_of_birth_enabled'], ['date_of_birth_enabled']) }} as date_of_birth_enabled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_entity_types') }}
-- entity_types
where 1 = 1
