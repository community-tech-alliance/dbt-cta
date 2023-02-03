{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_sms_message_activities') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['link'], ['link']) }} as link,
    {{ json_extract_scalar('_airbyte_data', ['links'], ['links']) }} as links,
    {{ json_extract_scalar('_airbyte_data', ['link_id'], ['link_id']) }} as link_id,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['group_id'], ['group_id']) }} as group_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['action_type'], ['action_type']) }} as action_type,
    {{ json_extract_scalar('_airbyte_data', ['recipient_id'], ['recipient_id']) }} as recipient_id,
    {{ json_extract_scalar('_airbyte_data', ['mobile_message_id'], ['mobile_message_id']) }} as mobile_message_id,
    {{ json_extract_scalar('_airbyte_data', ['twilio_message_id'], ['twilio_message_id']) }} as twilio_message_id,
    {{ json_extract_scalar('_airbyte_data', ['mobile_message_stat_id'], ['mobile_message_stat_id']) }} as mobile_message_stat_id,
    {{ json_extract_scalar('_airbyte_data', ['mobile_message_field_id'], ['mobile_message_field_id']) }} as mobile_message_field_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_sms_message_activities') }} as table_alias
-- sms_message_activities
where 1 = 1

