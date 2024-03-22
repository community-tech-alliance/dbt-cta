{% set raw_table = env_var("CTA_DATASET_ID") ~ "_airbyte_raw_message_activities" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
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
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
-- sms_message_activities
where 1 = 1
