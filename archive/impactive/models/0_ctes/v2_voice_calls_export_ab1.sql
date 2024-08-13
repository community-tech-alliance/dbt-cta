{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_v2_voice_calls_export') }}
select
    {{ json_extract_scalar('_airbyte_data', ['selected_voterbase_id'], ['selected_voterbase_id']) }} as selected_voterbase_id,
    {{ json_extract_scalar('_airbyte_data', ['user_last_name'], ['user_last_name']) }} as user_last_name,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['source'], ['source']) }} as source,
    {{ json_extract_scalar('_airbyte_data', ['contact_id'], ['contact_id']) }} as contact_id,
    {{ json_extract_scalar('_airbyte_data', ['duration'], ['duration']) }} as duration,
    {{ json_extract_scalar('_airbyte_data', ['reference'], ['reference']) }} as reference,
    {{ json_extract_scalar('_airbyte_data', ['van_id'], ['van_id']) }} as van_id,
    {{ json_extract_scalar('_airbyte_data', ['user_first_name'], ['user_first_name']) }} as user_first_name,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['stopped_reason'], ['stopped_reason']) }} as stopped_reason,
    {{ json_extract_scalar('_airbyte_data', ['reported'], ['reported']) }} as reported,
    {{ json_extract_scalar('_airbyte_data', ['activity_id'], ['activity_id']) }} as activity_id,
    {{ json_extract_scalar('_airbyte_data', ['activity_published_at'], ['activity_published_at']) }} as activity_published_at,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['stopped_at'], ['stopped_at']) }} as stopped_at,
    {{ json_extract_scalar('_airbyte_data', ['first_name'], ['first_name']) }} as first_name,
    {{ json_extract_scalar('_airbyte_data', ['campaign_id'], ['campaign_id']) }} as campaign_id,
    {{ json_extract_scalar('_airbyte_data', ['activity_title'], ['activity_title']) }} as activity_title,
    {{ json_extract_scalar('_airbyte_data', ['user_email'], ['user_email']) }} as user_email,
    {{ json_extract_scalar('_airbyte_data', ['twilio_answered_by'], ['twilio_answered_by']) }} as twilio_answered_by,
    {{ json_extract_scalar('_airbyte_data', ['last_name'], ['last_name']) }} as last_name,
    {{ json_extract_scalar('_airbyte_data', ['answered_at'], ['answered_at']) }} as answered_at,
    {{ json_extract_scalar('_airbyte_data', ['exported_at'], ['exported_at']) }} as exported_at,
    {{ json_extract_scalar('_airbyte_data', ['pdi_id'], ['pdi_id']) }} as pdi_id,
    {{ json_extract_scalar('_airbyte_data', ['phone'], ['phone']) }} as phone,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_v2_voice_calls_export') }} as table_alias
-- v2_voice_calls_export
where 1 = 1

