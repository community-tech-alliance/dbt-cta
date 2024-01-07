{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('users_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'current_longitude',
        'datatable_settings',
        'last_sign_in_ip',
        'two_factor_phone',
        'extras',
        'created_at',
        'direct_otp',
        'description',
        'sign_in_count',
        'current_sign_in_ip',
        'locale',
        'encrypted_otp_secret_key',
        'reset_password_token',
        'updated_at',
        'last_sign_in_at',
        'role_id',
        'turf_id',
        'trained_in_states',
        'encrypted_otp_secret_key_salt',
        'id',
        boolean_to_string('locked'),
        'first_name',
        'slug',
        'email',
        'current_sign_in_at',
        'encrypted_password',
        'second_factor_attempts_count',
        boolean_to_string('two_factor_enabled'),
        'phone_bank_sessions_count',
        'training_status',
        'two_factor_unverified_phone',
        'disabled_at',
        'totp_timestamp',
        'reset_password_sent_at',
        'last_name',
        'direct_otp_sent_at',
        'last_notified_at',
        'time_zone',
        'remember_created_at',
        'spoken_language_locales',
        'encrypted_otp_secret_key_iv',
        'notification_hour',
        'current_latitude',
        'avatar_data',
        array_to_string('notifications'),
    ]) }} as _airbyte_users_hashid,
    tmp.*
from {{ ref('users_ab2') }} as tmp
-- users
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

