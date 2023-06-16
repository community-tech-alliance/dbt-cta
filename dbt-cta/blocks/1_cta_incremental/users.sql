{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    schema = "sv_blocks",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('users_scd') }}
select
    _airbyte_unique_key,
    current_longitude,
    datatable_settings,
    last_sign_in_ip,
    two_factor_phone,
    extras,
    created_at,
    direct_otp,
    description,
    sign_in_count,
    current_sign_in_ip,
    locale,
    encrypted_otp_secret_key,
    reset_password_token,
    updated_at,
    last_sign_in_at,
    role_id,
    turf_id,
    trained_in_states,
    encrypted_otp_secret_key_salt,
    id,
    locked,
    first_name,
    slug,
    email,
    current_sign_in_at,
    encrypted_password,
    second_factor_attempts_count,
    two_factor_enabled,
    phone_bank_sessions_count,
    training_status,
    two_factor_unverified_phone,
    disabled_at,
    totp_timestamp,
    reset_password_sent_at,
    last_name,
    direct_otp_sent_at,
    last_notified_at,
    time_zone,
    remember_created_at,
    spoken_language_locales,
    encrypted_otp_secret_key_iv,
    notification_hour,
    current_latitude,
    avatar_data,
    notifications,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_users_hashid
from {{ ref('users_scd') }}
-- users from {{ source('sv_blocks', '_airbyte_raw_users') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}

