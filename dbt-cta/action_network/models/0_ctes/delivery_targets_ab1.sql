{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_delivery_targets') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['uuid'], ['uuid']) }} as uuid,
    {{ json_extract_scalar('_airbyte_data', ['bioid'], ['bioid']) }} as bioid,
    {{ json_extract_scalar('_airbyte_data', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['message'], ['message']) }} as message,
    {{ json_extract_scalar('_airbyte_data', ['subject'], ['subject']) }} as subject,
    {{ json_extract_scalar('_airbyte_data', ['form_data'], ['form_data']) }} as form_data,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['captcha_uid'], ['captcha_uid']) }} as captcha_uid,
    {{ json_extract_scalar('_airbyte_data', ['captcha_url'], ['captcha_url']) }} as captcha_url,
    {{ json_extract_scalar('_airbyte_data', ['delivery_id'], ['delivery_id']) }} as delivery_id,
    {{ json_extract_scalar('_airbyte_data', ['target_name'], ['target_name']) }} as target_name,
    {{ json_extract_scalar('_airbyte_data', ['target_party'], ['target_party']) }} as target_party,
    {{ json_extract_scalar('_airbyte_data', ['target_state'], ['target_state']) }} as target_state,
    {{ json_extract_scalar('_airbyte_data', ['delivery_method'], ['delivery_method']) }} as delivery_method,
    {{ json_extract_scalar('_airbyte_data', ['target_district'], ['target_district']) }} as target_district,
    {{ json_extract_scalar('_airbyte_data', ['target_position'], ['target_position']) }} as target_position,
    {{ json_extract_scalar('_airbyte_data', ['captcha_required'], ['captcha_required']) }} as captcha_required,
    {{ json_extract_scalar('_airbyte_data', ['letter_template_id'], ['letter_template_id']) }} as letter_template_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_delivery_targets') }} as table_alias
-- delivery_targets
where 1 = 1

