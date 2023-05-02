{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('users_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'uid',
        'role',
        'email',
        'tokens',
        'provider',
        'last_name',
        boolean_to_string('api_access'),
        'created_at',
        'deleted_at',
        'disable_on',
        'first_name',
        'updated_at',
        'confirmed_at',
        'phone_number',
        'invited_by_id',
        'sign_in_count',
        'invited_by_type',
        'last_sign_in_at',
        'last_sign_in_ip',
        'invitation_limit',
        'invitation_token',
        'invitations_count',
        'unconfirmed_email',
        'confirmation_token',
        'current_sign_in_at',
        'current_sign_in_ip',
        'encrypted_password',
        'invitation_sent_at',
        'remember_created_at',
        'authentication_token',
        'confirmation_sent_at',
        'reset_password_token',
        boolean_to_string('allow_password_change'),
        'invitation_created_at',
        'invitation_accepted_at',
        'reset_password_sent_at',
    ]) }} as _airbyte_users_hashid,
    tmp.*
from {{ ref('users_ab2') }} tmp
-- users
where 1 = 1

