{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'users') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    slug,
    email,
    extras,
    locale,
    locked,
    role_id,
    turf_id,
    last_name,
    qc_office,
    time_zone,
    created_at,
    direct_otp,
    first_name,
    updated_at,
    avatar_data,
    description,
    disabled_at,
    notifications,
    sign_in_count,
    totp_timestamp,
    last_sign_in_at,
    last_sign_in_ip,
    training_status,
    current_latitude,
    last_notified_at,
    two_factor_phone,
    current_longitude,
    notification_hour,
    trained_in_states,
    current_sign_in_at,
    current_sign_in_ip,
    datatable_settings,
    direct_otp_sent_at,
    encrypted_password,
    two_factor_enabled,
    remember_created_at,
    notifications_legacy,
    reset_password_token,
    force_reauthentication,
    reset_password_sent_at,
    spoken_language_locales,
    encrypted_otp_secret_key,
    phone_bank_sessions_count,
    encrypted_otp_secret_key_iv,
    two_factor_unverified_phone,
    second_factor_attempts_count,
    encrypted_otp_secret_key_salt,
   {{ dbt_utils.surrogate_key([
     'id',
    'slug',
    'email',
    'extras',
    'locale',
    'locked',
    'role_id',
    'turf_id',
    'last_name',
    'qc_office',
    'time_zone',
    'direct_otp',
    'first_name',
    'avatar_data',
    'description',
    'sign_in_count',
    'last_sign_in_ip',
    'training_status',
    'two_factor_phone',
    'notification_hour',
    'trained_in_states',
    'current_sign_in_ip',
    'datatable_settings',
    'encrypted_password',
    'two_factor_enabled',
    'reset_password_token',
    'force_reauthentication',
    'spoken_language_locales',
    'encrypted_otp_secret_key',
    'phone_bank_sessions_count',
    'encrypted_otp_secret_key_iv',
    'two_factor_unverified_phone',
    'second_factor_attempts_count',
    'encrypted_otp_secret_key_salt'
    ]) }} as _airbyte_users_hashid
from {{ source('cta', 'users') }}
