{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_message') }}
select
    {{ json_extract_scalar('_airbyte_data', ['is_from_contact'], ['is_from_contact']) }} as is_from_contact,
    {{ json_extract_scalar('_airbyte_data', ['campaign_contact_id'], ['campaign_contact_id']) }} as campaign_contact_id,
    {{ json_extract_scalar('_airbyte_data', ['queued_at'], ['queued_at']) }} as queued_at,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['media'], ['media']) }} as media,
    {{ json_extract_scalar('_airbyte_data', ['send_before'], ['send_before']) }} as send_before,
    {{ json_extract_scalar('_airbyte_data', ['contact_number'], ['contact_number']) }} as contact_number,
    {{ json_extract_scalar('_airbyte_data', ['user_number'], ['user_number']) }} as user_number,
    {{ json_extract_scalar('_airbyte_data', ['sent_at'], ['sent_at']) }} as sent_at,
    {{ json_extract_scalar('_airbyte_data', ['assignment_id'], ['assignment_id']) }} as assignment_id,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['service'], ['service']) }} as service,
    {{ json_extract_scalar('_airbyte_data', ['service_id'], ['service_id']) }} as service_id,
    {{ json_extract_scalar('_airbyte_data', ['send_status'], ['send_status']) }} as send_status,
    {{ json_extract_scalar('_airbyte_data', ['messageservice_sid'], ['messageservice_sid']) }} as messageservice_sid,
    {{ json_extract_scalar('_airbyte_data', ['error_code'], ['error_code']) }} as error_code,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['text'], ['text']) }} as text,
    {{ json_extract_scalar('_airbyte_data', ['service_response_at'], ['service_response_at']) }} as service_response_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_message') }} as table_alias
-- message
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

