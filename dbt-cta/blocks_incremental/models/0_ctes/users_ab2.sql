{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('users_ab1') }}
select
    cast(current_longitude as {{ dbt_utils.type_float() }}) as current_longitude,
    cast(datatable_settings as {{ dbt_utils.type_string() }}) as datatable_settings,
    cast(last_sign_in_ip as {{ dbt_utils.type_string() }}) as last_sign_in_ip,
    cast(two_factor_phone as {{ dbt_utils.type_string() }}) as two_factor_phone,
    cast(extras as {{ dbt_utils.type_string() }}) as extras,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(direct_otp as {{ dbt_utils.type_string() }}) as direct_otp,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(sign_in_count as {{ dbt_utils.type_bigint() }}) as sign_in_count,
    cast(current_sign_in_ip as {{ dbt_utils.type_string() }}) as current_sign_in_ip,
    cast(locale as {{ dbt_utils.type_string() }}) as locale,
    cast(encrypted_otp_secret_key as {{ dbt_utils.type_string() }}) as encrypted_otp_secret_key,
    cast(reset_password_token as {{ dbt_utils.type_string() }}) as reset_password_token,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast({{ empty_string_to_null('last_sign_in_at') }} as {{ type_timestamp_without_timezone() }}) as last_sign_in_at,
    cast(role_id as {{ dbt_utils.type_bigint() }}) as role_id,
    cast(turf_id as {{ dbt_utils.type_bigint() }}) as turf_id,
    cast(trained_in_states as {{ dbt_utils.type_string() }}) as trained_in_states,
    cast(encrypted_otp_secret_key_salt as {{ dbt_utils.type_string() }}) as encrypted_otp_secret_key_salt,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    {{ cast_to_boolean('locked') }} as locked,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    cast(slug as {{ dbt_utils.type_string() }}) as slug,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast({{ empty_string_to_null('current_sign_in_at') }} as {{ type_timestamp_without_timezone() }}) as current_sign_in_at,
    cast(encrypted_password as {{ dbt_utils.type_string() }}) as encrypted_password,
    cast(second_factor_attempts_count as {{ dbt_utils.type_bigint() }}) as second_factor_attempts_count,
    {{ cast_to_boolean('two_factor_enabled') }} as two_factor_enabled,
    cast(phone_bank_sessions_count as {{ dbt_utils.type_bigint() }}) as phone_bank_sessions_count,
    cast(training_status as {{ dbt_utils.type_string() }}) as training_status,
    cast(two_factor_unverified_phone as {{ dbt_utils.type_string() }}) as two_factor_unverified_phone,
    cast({{ empty_string_to_null('disabled_at') }} as {{ type_timestamp_without_timezone() }}) as disabled_at,
    cast({{ empty_string_to_null('totp_timestamp') }} as {{ type_timestamp_without_timezone() }}) as totp_timestamp,
    cast({{ empty_string_to_null('reset_password_sent_at') }} as {{ type_timestamp_without_timezone() }}) as reset_password_sent_at,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast({{ empty_string_to_null('direct_otp_sent_at') }} as {{ type_timestamp_without_timezone() }}) as direct_otp_sent_at,
    cast({{ empty_string_to_null('last_notified_at') }} as {{ type_timestamp_without_timezone() }}) as last_notified_at,
    cast(time_zone as {{ dbt_utils.type_string() }}) as time_zone,
    cast({{ empty_string_to_null('remember_created_at') }} as {{ type_timestamp_without_timezone() }}) as remember_created_at,
    cast(spoken_language_locales as {{ dbt_utils.type_string() }}) as spoken_language_locales,
    cast(encrypted_otp_secret_key_iv as {{ dbt_utils.type_string() }}) as encrypted_otp_secret_key_iv,
    cast(notification_hour as {{ dbt_utils.type_bigint() }}) as notification_hour,
    cast(current_latitude as {{ dbt_utils.type_float() }}) as current_latitude,
    cast(avatar_data as {{ dbt_utils.type_string() }}) as avatar_data,
    notifications,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('users_ab1') }}
-- users
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

