{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_rsvps') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['city'], ['city']) }} as city,
    {{ json_extract_scalar('_airbyte_data', ['uuid'], ['uuid']) }} as uuid,
    {{ json_extract_scalar('_airbyte_data', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('_airbyte_data', ['phone'], ['phone']) }} as phone,
    {{ json_extract_scalar('_airbyte_data', ['street'], ['street']) }} as street,
    {{ json_extract_scalar('_airbyte_data', ['country'], ['country']) }} as country,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['event_id'], ['event_id']) }} as event_id,
    {{ json_extract_scalar('_airbyte_data', ['tag_list'], ['tag_list']) }} as tag_list,
    {{ json_extract_scalar('_airbyte_data', ['zip_code'], ['zip_code']) }} as zip_code,
    {{ json_extract_scalar('_airbyte_data', ['last_name'], ['last_name']) }} as last_name,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['first_name'], ['first_name']) }} as first_name,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['guest_count'], ['guest_count']) }} as guest_count,
    {{ json_extract_scalar('_airbyte_data', ['display_name'], ['display_name']) }} as display_name,
    {{ json_extract_scalar('_airbyte_data', ['custom_fields'], ['custom_fields']) }} as custom_fields,
    {{ json_extract_scalar('_airbyte_data', ['message_to_target'], ['message_to_target']) }} as message_to_target,
    {{ json_extract_scalar('_airbyte_data', ['originating_system'], ['originating_system']) }} as originating_system,
    {{ json_extract_scalar('_airbyte_data', ['updates_from_creator'], ['updates_from_creator']) }} as updates_from_creator,
    {{ json_extract_scalar('_airbyte_data', ['updates_from_sponsor'], ['updates_from_sponsor']) }} as updates_from_sponsor,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_rsvps') }} as table_alias
-- rsvps
where 1 = 1

