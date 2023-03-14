{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('applications_ab1') }}
select
    cast(sid as {{ dbt_utils.type_string() }}) as sid,
    cast(uri as {{ dbt_utils.type_string() }}) as uri,
    cast(sms_url as {{ dbt_utils.type_string() }}) as sms_url,
    cast(voice_url as {{ dbt_utils.type_string() }}) as voice_url,
    cast(sms_method as {{ dbt_utils.type_string() }}) as sms_method,
    cast(account_sid as {{ dbt_utils.type_string() }}) as account_sid,
    cast(api_version as {{ dbt_utils.type_string() }}) as api_version,
    cast({{ empty_string_to_null('date_created') }} as {{ type_timestamp_with_timezone() }}) as date_created,
    cast({{ empty_string_to_null('date_updated') }} as {{ type_timestamp_with_timezone() }}) as date_updated,
    cast(voice_method as {{ dbt_utils.type_string() }}) as voice_method,
    cast(friendly_name as {{ dbt_utils.type_string() }}) as friendly_name,
    cast(status_callback as {{ dbt_utils.type_string() }}) as status_callback,
    cast(sms_fallback_url as {{ dbt_utils.type_string() }}) as sms_fallback_url,
    cast(voice_fallback_url as {{ dbt_utils.type_string() }}) as voice_fallback_url,
    cast(sms_fallback_method as {{ dbt_utils.type_string() }}) as sms_fallback_method,
    cast(sms_status_callback as {{ dbt_utils.type_string() }}) as sms_status_callback,
    cast(voice_fallback_method as {{ dbt_utils.type_string() }}) as voice_fallback_method,
    cast(status_callback_method as {{ dbt_utils.type_string() }}) as status_callback_method,
    {{ cast_to_boolean('voice_caller_id_lookup') }} as voice_caller_id_lookup,
    cast(message_status_callback as {{ dbt_utils.type_string() }}) as message_status_callback,
    {{ cast_to_boolean('public_application_connect_enabled') }} as public_application_connect_enabled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('applications_ab1') }}
-- applications
where 1 = 1

