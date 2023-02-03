{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_syndications') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['uuid'], ['uuid']) }} as uuid,
    {{ json_extract_scalar('_airbyte_data', ['stats'], ['stats']) }} as stats,
    {{ json_extract_scalar('_airbyte_data', ['title'], ['title']) }} as title,
    {{ json_extract_scalar('_airbyte_data', ['hidden'], ['hidden']) }} as hidden,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['email_id'], ['email_id']) }} as email_id,
    {{ json_extract_scalar('_airbyte_data', ['group_id'], ['group_id']) }} as group_id,
    {{ json_extract_scalar('_airbyte_data', ['action_id'], ['action_id']) }} as action_id,
    {{ json_extract_scalar('_airbyte_data', ['permalink'], ['permalink']) }} as permalink,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['action_type'], ['action_type']) }} as action_type,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['first_publish'], ['first_publish']) }} as first_publish,
    {{ json_extract_scalar('_airbyte_data', ['salesforce_id'], ['salesforce_id']) }} as salesforce_id,
    {{ json_extract_scalar('_airbyte_data', ['display_creator'], ['display_creator']) }} as display_creator,
    {{ json_extract_scalar('_airbyte_data', ['first_permalink'], ['first_permalink']) }} as first_permalink,
    {{ json_extract_scalar('_airbyte_data', ['photo_file_name'], ['photo_file_name']) }} as photo_file_name,
    {{ json_extract_scalar('_airbyte_data', ['photo_file_size'], ['photo_file_size']) }} as photo_file_size,
    {{ json_extract_scalar('_airbyte_data', ['originating_system'], ['originating_system']) }} as originating_system,
    {{ json_extract_scalar('_airbyte_data', ['photo_content_type'], ['photo_content_type']) }} as photo_content_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_syndications') }} as table_alias
-- syndications
where 1 = 1

