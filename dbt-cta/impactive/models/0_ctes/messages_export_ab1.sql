{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_messages_export') }}
select
    {{ json_extract_scalar('_airbyte_data', ['sender_van_id'], ['sender_van_id']) }} as sender_van_id,
    {{ json_extract_scalar('_airbyte_data', ['receiver_selected_voterbase_id'], ['receiver_selected_voterbase_id']) }} as receiver_selected_voterbase_id,
    {{ json_extract_scalar('_airbyte_data', ['receiver_id'], ['receiver_id']) }} as receiver_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['sender_name'], ['sender_name']) }} as sender_name,
    {{ json_extract_scalar('_airbyte_data', ['body'], ['body']) }} as body,
    {{ json_extract_scalar('_airbyte_data', ['sender_selected_voterbase_id'], ['sender_selected_voterbase_id']) }} as sender_selected_voterbase_id,
    {{ json_extract_scalar('_airbyte_data', ['sender_id'], ['sender_id']) }} as sender_id,
    {{ json_extract_scalar('_airbyte_data', ['receiver_type'], ['receiver_type']) }} as receiver_type,
    {{ json_extract_scalar('_airbyte_data', ['aasm_message'], ['aasm_message']) }} as aasm_message,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['activity_type'], ['activity_type']) }} as activity_type,
    {{ json_extract_scalar('_airbyte_data', ['activity_id'], ['activity_id']) }} as activity_id,
    {{ json_extract_scalar('_airbyte_data', ['receiver_name'], ['receiver_name']) }} as receiver_name,
    {{ json_extract_scalar('_airbyte_data', ['activity_published_at'], ['activity_published_at']) }} as activity_published_at,
    {{ json_extract_scalar('_airbyte_data', ['activity_script_id'], ['activity_script_id']) }} as activity_script_id,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['aasm_state'], ['aasm_state']) }} as aasm_state,
    {{ json_extract_scalar('_airbyte_data', ['receiver_raw'], ['receiver_raw']) }} as receiver_raw,
    {{ json_extract_scalar('_airbyte_data', ['twilio_segments'], ['twilio_segments']) }} as twilio_segments,
    {{ json_extract_scalar('_airbyte_data', ['campaign_id'], ['campaign_id']) }} as campaign_id,
    {{ json_extract_scalar('_airbyte_data', ['activity_title'], ['activity_title']) }} as activity_title,
    {{ json_extract_scalar('_airbyte_data', ['sender_raw'], ['sender_raw']) }} as sender_raw,
    {{ json_extract_scalar('_airbyte_data', ['sender_type'], ['sender_type']) }} as sender_type,
    {{ json_extract_scalar('_airbyte_data', ['twilio_status'], ['twilio_status']) }} as twilio_status,
    {{ json_extract_scalar('_airbyte_data', ['message_type'], ['message_type']) }} as message_type,
    {{ json_extract_scalar('_airbyte_data', ['script_name'], ['script_name']) }} as script_name,
    {{ json_extract_scalar('_airbyte_data', ['exported_at'], ['exported_at']) }} as exported_at,
    {{ json_extract_scalar('_airbyte_data', ['sent_at'], ['sent_at']) }} as sent_at,
    {{ json_extract_scalar('_airbyte_data', ['received_at'], ['received_at']) }} as received_at,
    {{ json_extract_scalar('_airbyte_data', ['error_code'], ['error_code']) }} as error_code,
    {{ json_extract_scalar('_airbyte_data', ['script_type'], ['script_type']) }} as script_type,
    {{ json_extract_scalar('_airbyte_data', ['receiver_van_id'], ['receiver_van_id']) }} as receiver_van_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_messages_export') }} as table_alias
-- messages_export
where 1 = 1

