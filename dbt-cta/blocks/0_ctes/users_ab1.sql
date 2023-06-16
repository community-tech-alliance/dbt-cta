{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('sv_blocks', '_airbyte_raw_users') }}
select
    {{ json_extract_scalar('_airbyte_data', ['current_longitude'], ['current_longitude']) }} as current_longitude,
    {{ json_extract_scalar('_airbyte_data', ['datatable_settings'], ['datatable_settings']) }} as datatable_settings,
    {{ json_extract_scalar('_airbyte_data', ['last_sign_in_ip'], ['last_sign_in_ip']) }} as last_sign_in_ip,
    {{ json_extract_scalar('_airbyte_data', ['two_factor_phone'], ['two_factor_phone']) }} as two_factor_phone,
    {{ json_extract_scalar('_airbyte_data', ['extras'], ['extras']) }} as extras,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['direct_otp'], ['direct_otp']) }} as direct_otp,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['sign_in_count'], ['sign_in_count']) }} as sign_in_count,
    {{ json_extract_scalar('_airbyte_data', ['current_sign_in_ip'], ['current_sign_in_ip']) }} as current_sign_in_ip,
    {{ json_extract_scalar('_airbyte_data', ['locale'], ['locale']) }} as locale,
    {{ json_extract_scalar('_airbyte_data', ['encrypted_otp_secret_key'], ['encrypted_otp_secret_key']) }} as encrypted_otp_secret_key,
    {{ json_extract_scalar('_airbyte_data', ['reset_password_token'], ['reset_password_token']) }} as reset_password_token,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['last_sign_in_at'], ['last_sign_in_at']) }} as last_sign_in_at,
    {{ json_extract_scalar('_airbyte_data', ['role_id'], ['role_id']) }} as role_id,
    {{ json_extract_scalar('_airbyte_data', ['turf_id'], ['turf_id']) }} as turf_id,
    {{ json_extract_scalar('_airbyte_data', ['trained_in_states'], ['trained_in_states']) }} as trained_in_states,
    {{ json_extract_scalar('_airbyte_data', ['encrypted_otp_secret_key_salt'], ['encrypted_otp_secret_key_salt']) }} as encrypted_otp_secret_key_salt,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['locked'], ['locked']) }} as locked,
    {{ json_extract_scalar('_airbyte_data', ['first_name'], ['first_name']) }} as first_name,
    {{ json_extract_scalar('_airbyte_data', ['slug'], ['slug']) }} as slug,
    {{ json_extract_scalar('_airbyte_data', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('_airbyte_data', ['current_sign_in_at'], ['current_sign_in_at']) }} as current_sign_in_at,
    {{ json_extract_scalar('_airbyte_data', ['encrypted_password'], ['encrypted_password']) }} as encrypted_password,
    {{ json_extract_scalar('_airbyte_data', ['second_factor_attempts_count'], ['second_factor_attempts_count']) }} as second_factor_attempts_count,
    {{ json_extract_scalar('_airbyte_data', ['two_factor_enabled'], ['two_factor_enabled']) }} as two_factor_enabled,
    {{ json_extract_scalar('_airbyte_data', ['phone_bank_sessions_count'], ['phone_bank_sessions_count']) }} as phone_bank_sessions_count,
    {{ json_extract_scalar('_airbyte_data', ['training_status'], ['training_status']) }} as training_status,
    {{ json_extract_scalar('_airbyte_data', ['two_factor_unverified_phone'], ['two_factor_unverified_phone']) }} as two_factor_unverified_phone,
    {{ json_extract_scalar('_airbyte_data', ['disabled_at'], ['disabled_at']) }} as disabled_at,
    {{ json_extract_scalar('_airbyte_data', ['totp_timestamp'], ['totp_timestamp']) }} as totp_timestamp,
    {{ json_extract_scalar('_airbyte_data', ['reset_password_sent_at'], ['reset_password_sent_at']) }} as reset_password_sent_at,
    {{ json_extract_scalar('_airbyte_data', ['last_name'], ['last_name']) }} as last_name,
    {{ json_extract_scalar('_airbyte_data', ['direct_otp_sent_at'], ['direct_otp_sent_at']) }} as direct_otp_sent_at,
    {{ json_extract_scalar('_airbyte_data', ['last_notified_at'], ['last_notified_at']) }} as last_notified_at,
    {{ json_extract_scalar('_airbyte_data', ['time_zone'], ['time_zone']) }} as time_zone,
    {{ json_extract_scalar('_airbyte_data', ['remember_created_at'], ['remember_created_at']) }} as remember_created_at,
    {{ json_extract_scalar('_airbyte_data', ['spoken_language_locales'], ['spoken_language_locales']) }} as spoken_language_locales,
    {{ json_extract_scalar('_airbyte_data', ['encrypted_otp_secret_key_iv'], ['encrypted_otp_secret_key_iv']) }} as encrypted_otp_secret_key_iv,
    {{ json_extract_scalar('_airbyte_data', ['notification_hour'], ['notification_hour']) }} as notification_hour,
    {{ json_extract_scalar('_airbyte_data', ['current_latitude'], ['current_latitude']) }} as current_latitude,
    {{ json_extract_scalar('_airbyte_data', ['avatar_data'], ['avatar_data']) }} as avatar_data,
    {{ json_extract_string_array('_airbyte_data', ['notifications'], ['notifications']) }} as notifications,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('sv_blocks', '_airbyte_raw_users') }} as table_alias
-- users
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

