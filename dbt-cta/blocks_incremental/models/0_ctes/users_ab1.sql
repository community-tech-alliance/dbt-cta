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
    force_reauthentication,
    last_notified_at,
    time_zone,
    remember_created_at,
    spoken_language_locales,
    encrypted_otp_secret_key_iv,
    notification_hour,
    current_latitude,
    avatar_data,
    qc_office,
    notifications,
   {{ dbt_utils.surrogate_key([
     'datatable_settings',
    'last_sign_in_ip',
    'two_factor_phone',
    'extras',
    'direct_otp',
    'description',
    'sign_in_count',
    'current_sign_in_ip',
    'locale',
    'encrypted_otp_secret_key',
    'reset_password_token',
    'role_id',
    'turf_id',
    'trained_in_states',
    'encrypted_otp_secret_key_salt',
    'id',
    'locked',
    'first_name',
    'slug',
    'email',
    'encrypted_password',
    'second_factor_attempts_count',
    'two_factor_enabled',
    'phone_bank_sessions_count',
    'training_status',
    'two_factor_unverified_phone',
    'last_name',
    'force_reauthentication',
    'time_zone',
    'spoken_language_locales',
    'encrypted_otp_secret_key_iv',
    'notification_hour',
    'avatar_data',
    'qc_office'
    ]) }} as _airbyte_users_hashid
from {{ source('cta', 'users') }}
