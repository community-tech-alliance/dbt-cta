{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_incoming_phone_numbers') }}
select
    {{ json_extract_scalar('_airbyte_data', ['sid'], ['sid']) }} as sid,
    {{ json_extract_scalar('_airbyte_data', ['uri'], ['uri']) }} as uri,
    {{ json_extract_scalar('_airbyte_data', ['beta'], ['beta']) }} as beta,
    {{ json_extract_scalar('_airbyte_data', ['origin'], ['origin']) }} as origin,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['sms_url'], ['sms_url']) }} as sms_url,
    {{ json_extract_scalar('_airbyte_data', ['trunk_sid'], ['trunk_sid']) }} as trunk_sid,
    {{ json_extract_scalar('_airbyte_data', ['voice_url'], ['voice_url']) }} as voice_url,
    {{ json_extract_scalar('_airbyte_data', ['bundle_sid'], ['bundle_sid']) }} as bundle_sid,
    {{ json_extract_scalar('_airbyte_data', ['sms_method'], ['sms_method']) }} as sms_method,
    {{ json_extract_scalar('_airbyte_data', ['account_sid'], ['account_sid']) }} as account_sid,
    {{ json_extract_scalar('_airbyte_data', ['address_sid'], ['address_sid']) }} as address_sid,
    {{ json_extract_scalar('_airbyte_data', ['api_version'], ['api_version']) }} as api_version,
    {{ json_extract('table_alias', '_airbyte_data', ['capabilities'], ['capabilities']) }} as capabilities,
    {{ json_extract_scalar('_airbyte_data', ['capabilities','mms'], ['capabilities','mms']) }} as capabilities_MMS,
    {{ json_extract_scalar('_airbyte_data', ['capabilities','sms'], ['capabilities','sms']) }} as capabilities_SMS,
    {{ json_extract_scalar('_airbyte_data', ['capabilities','voice'], ['capabilities','voice']) }} as capabilities_voice,
    {{ json_extract_scalar('_airbyte_data', ['date_created'], ['date_created']) }} as date_created,
    {{ json_extract_scalar('_airbyte_data', ['date_updated'], ['date_updated']) }} as date_updated,
    {{ json_extract_scalar('_airbyte_data', ['identity_sid'], ['identity_sid']) }} as identity_sid,
    {{ json_extract_scalar('_airbyte_data', ['phone_number'], ['phone_number']) }} as phone_number,
    {{ json_extract_scalar('_airbyte_data', ['voice_method'], ['voice_method']) }} as voice_method,
    {{ json_extract_scalar('_airbyte_data', ['friendly_name'], ['friendly_name']) }} as friendly_name,
    {{ json_extract_scalar('_airbyte_data', ['status_callback'], ['status_callback']) }} as status_callback,
    {{ json_extract_scalar('_airbyte_data', ['emergency_status'], ['emergency_status']) }} as emergency_status,
    {{ json_extract_scalar('_airbyte_data', ['sms_fallback_url'], ['sms_fallback_url']) }} as sms_fallback_url,
    {{ json_extract_scalar('_airbyte_data', ['voice_fallback_url'], ['voice_fallback_url']) }} as voice_fallback_url,
    {{ json_extract_scalar('_airbyte_data', ['voice_receive_mode'], ['voice_receive_mode']) }} as voice_receive_mode,
    {{ json_extract_scalar('_airbyte_data', ['sms_application_sid'], ['sms_application_sid']) }} as sms_application_sid,
    {{ json_extract_scalar('_airbyte_data', ['sms_fallback_method'], ['sms_fallback_method']) }} as sms_fallback_method,
    {{ json_extract_scalar('_airbyte_data', ['address_requirements'], ['address_requirements']) }} as address_requirements,
    {{ json_extract_scalar('_airbyte_data', ['emergency_address_sid'], ['emergency_address_sid']) }} as emergency_address_sid,
    {{ json_extract_scalar('_airbyte_data', ['voice_application_sid'], ['voice_application_sid']) }} as voice_application_sid,
    {{ json_extract_scalar('_airbyte_data', ['voice_fallback_method'], ['voice_fallback_method']) }} as voice_fallback_method,
    {{ json_extract_scalar('_airbyte_data', ['status_callback_method'], ['status_callback_method']) }} as status_callback_method,
    {{ json_extract_scalar('_airbyte_data', ['voice_caller_id_lookup'], ['voice_caller_id_lookup']) }} as voice_caller_id_lookup,
    {{ json_extract_scalar('_airbyte_data', ['emergency_address_status'], ['emergency_address_status']) }} as emergency_address_status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_incoming_phone_numbers') }} as table_alias
-- incoming_phone_numbers
where 1 = 1
