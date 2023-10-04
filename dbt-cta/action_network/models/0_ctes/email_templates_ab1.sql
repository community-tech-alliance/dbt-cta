{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_email_templates') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['uuid'], ['uuid']) }} as uuid,
    {{ json_extract_scalar('_airbyte_data', ['notes'], ['notes']) }} as notes,
    {{ json_extract_scalar('_airbyte_data', ['footer'], ['footer']) }} as footer,
    {{ json_extract_scalar('_airbyte_data', ['header'], ['header']) }} as header,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['group_id'], ['group_id']) }} as group_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['syndicated'], ['syndicated']) }} as syndicated,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['from_suffix'], ['from_suffix']) }} as from_suffix,
    {{ json_extract_scalar('_airbyte_data', ['unsubscribe'], ['unsubscribe']) }} as unsubscribe,
    {{ json_extract_scalar('_airbyte_data', ['logo_file_name'], ['logo_file_name']) }} as logo_file_name,
    {{ json_extract_scalar('_airbyte_data', ['logo_file_size'], ['logo_file_size']) }} as logo_file_size,
    {{ json_extract_scalar('_airbyte_data', ['logo_dimensions'], ['logo_dimensions']) }} as logo_dimensions,
    {{ json_extract_scalar('_airbyte_data', ['logo_content_type'], ['logo_content_type']) }} as logo_content_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_email_templates') }}
-- email_templates
where 1 = 1
