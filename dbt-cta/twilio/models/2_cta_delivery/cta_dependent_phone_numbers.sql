select
    _airbyte_emitted_at,
    sid,
    uri,
    sms_url,
    trunk_sid,
    voice_url,
    sms_method,
    account_sid,
    api_version,
    capabilities_MMS,
    capabilities_SMS,
    capabilities_voice,
    date_created,
    date_updated,
    phone_number,
    voice_method,
    friendly_name,
    status_callback,
    emergency_status,
    sms_fallback_url,
    voice_fallback_url,
    sms_application_sid,
    sms_fallback_method,
    address_requirements,
    emergency_address_sid,
    voice_application_sid,
    voice_fallback_method,
    status_callback_method,
    voice_caller_id_lookup
from {{ source('cta','dependent_phone_numbers_base') }}
