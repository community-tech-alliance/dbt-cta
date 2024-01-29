{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('users_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'info',
        'role',
        'uuid',
        'agree',
        'email',
        'stats',
        'language',
        'auth_hash',
        'permalink',
        'created_at',
        'deleted_at',
        'updated_at',
        'confirmed_at',
        'lists_enabled',
        'root_group_id',
        'sign_in_count',
        'is_super_admin',
        'last_sign_in_at',
        'last_sign_in_ip',
        'avatar_file_name',
        'avatar_file_size',
        'save_credit_card',
        'redirects_enabled',
        'unconfirmed_email',
        'current_sign_in_at',
        'current_sign_in_ip',
        'originating_system',
        'avatar_content_type',
        'enable_applications',
        'remember_created_at',
        'confirmation_sent_at',
        'custom_fields_enabled',
        'reset_password_sent_at',
        'salesforce_last_update',
        'current_page_wrapper_id',
        'email_templates_enabled',
        'salesforce_sync_enabled',
        'salesforce_custom_fields',
        'credit_card_last_4_digits',
        'current_email_template_id',
        'salesforce_sync_successful',
        'receive_transactional_email',
    ]) }} as _airbyte_users_hashid,
    tmp.*
from {{ ref('users_ab2') }} as tmp
-- users
where 1 = 1
