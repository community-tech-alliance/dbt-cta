{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('dependent_phone_numbers_ab1') }}
select
    cast(sid as {{ dbt_utils.type_string() }}) as sid,
    cast(uri as {{ dbt_utils.type_string() }}) as uri,
    cast(sms_url as {{ dbt_utils.type_string() }}) as sms_url,
    cast(trunk_sid as {{ dbt_utils.type_string() }}) as trunk_sid,
    cast(voice_url as {{ dbt_utils.type_string() }}) as voice_url,
    cast(sms_method as {{ dbt_utils.type_string() }}) as sms_method,
    cast(account_sid as {{ dbt_utils.type_string() }}) as account_sid,
    cast(api_version as {{ dbt_utils.type_string() }}) as api_version,
    cast(capabilities as {{ type_json() }}) as capabilities,
    {{ cast_to_boolean('capabilities_MMS') }} as capabilities_MMS,
    {{ cast_to_boolean('capabilities_SMS') }} as capabilities_SMS,
    {{ cast_to_boolean('capabilities_voice') }} as capabilities_voice,
    cast({{ empty_string_to_null('date_created') }} as {{ type_timestamp_with_timezone() }}) as date_created,
    cast({{ empty_string_to_null('date_updated') }} as {{ type_timestamp_with_timezone() }}) as date_updated,
    cast(phone_number as {{ dbt_utils.type_string() }}) as phone_number,
    cast(voice_method as {{ dbt_utils.type_string() }}) as voice_method,
    cast(friendly_name as {{ dbt_utils.type_string() }}) as friendly_name,
    cast(status_callback as {{ dbt_utils.type_string() }}) as status_callback,
    cast(emergency_status as {{ dbt_utils.type_string() }}) as emergency_status,
    cast(sms_fallback_url as {{ dbt_utils.type_string() }}) as sms_fallback_url,
    cast(voice_fallback_url as {{ dbt_utils.type_string() }}) as voice_fallback_url,
    cast(sms_application_sid as {{ dbt_utils.type_string() }}) as sms_application_sid,
    cast(sms_fallback_method as {{ dbt_utils.type_string() }}) as sms_fallback_method,
    cast(address_requirements as {{ dbt_utils.type_string() }}) as address_requirements,
    cast(emergency_address_sid as {{ dbt_utils.type_string() }}) as emergency_address_sid,
    cast(voice_application_sid as {{ dbt_utils.type_string() }}) as voice_application_sid,
    cast(voice_fallback_method as {{ dbt_utils.type_string() }}) as voice_fallback_method,
    cast(status_callback_method as {{ dbt_utils.type_string() }}) as status_callback_method,
    {{ cast_to_boolean('voice_caller_id_lookup') }} as voice_caller_id_lookup,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('dependent_phone_numbers_ab1') }}
-- dependent_phone_numbers
where 1 = 1
