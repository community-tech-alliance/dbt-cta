{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_users') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['info'], ['info']) }} as info,
    {{ json_extract_scalar('_airbyte_data', ['role'], ['role']) }} as role,
    {{ json_extract_scalar('_airbyte_data', ['uuid'], ['uuid']) }} as uuid,
    {{ json_extract_scalar('_airbyte_data', ['agree'], ['agree']) }} as agree,
    {{ json_extract_scalar('_airbyte_data', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('_airbyte_data', ['stats'], ['stats']) }} as stats,
    {{ json_extract_scalar('_airbyte_data', ['language'], ['language']) }} as language,
    {{ json_extract_scalar('_airbyte_data', ['auth_hash'], ['auth_hash']) }} as auth_hash,
    {{ json_extract_scalar('_airbyte_data', ['permalink'], ['permalink']) }} as permalink,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['deleted_at'], ['deleted_at']) }} as deleted_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['confirmed_at'], ['confirmed_at']) }} as confirmed_at,
    {{ json_extract_scalar('_airbyte_data', ['lists_enabled'], ['lists_enabled']) }} as lists_enabled,
    {{ json_extract_scalar('_airbyte_data', ['root_group_id'], ['root_group_id']) }} as root_group_id,
    {{ json_extract_scalar('_airbyte_data', ['sign_in_count'], ['sign_in_count']) }} as sign_in_count,
    {{ json_extract_scalar('_airbyte_data', ['is_super_admin'], ['is_super_admin']) }} as is_super_admin,
    {{ json_extract_scalar('_airbyte_data', ['last_sign_in_at'], ['last_sign_in_at']) }} as last_sign_in_at,
    {{ json_extract_scalar('_airbyte_data', ['last_sign_in_ip'], ['last_sign_in_ip']) }} as last_sign_in_ip,
    {{ json_extract_scalar('_airbyte_data', ['avatar_file_name'], ['avatar_file_name']) }} as avatar_file_name,
    {{ json_extract_scalar('_airbyte_data', ['avatar_file_size'], ['avatar_file_size']) }} as avatar_file_size,
    {{ json_extract_scalar('_airbyte_data', ['save_credit_card'], ['save_credit_card']) }} as save_credit_card,
    {{ json_extract_scalar('_airbyte_data', ['redirects_enabled'], ['redirects_enabled']) }} as redirects_enabled,
    {{ json_extract_scalar('_airbyte_data', ['unconfirmed_email'], ['unconfirmed_email']) }} as unconfirmed_email,
    {{ json_extract_scalar('_airbyte_data', ['current_sign_in_at'], ['current_sign_in_at']) }} as current_sign_in_at,
    {{ json_extract_scalar('_airbyte_data', ['current_sign_in_ip'], ['current_sign_in_ip']) }} as current_sign_in_ip,
    {{ json_extract_scalar('_airbyte_data', ['originating_system'], ['originating_system']) }} as originating_system,
    {{ json_extract_scalar('_airbyte_data', ['avatar_content_type'], ['avatar_content_type']) }} as avatar_content_type,
    {{ json_extract_scalar('_airbyte_data', ['enable_applications'], ['enable_applications']) }} as enable_applications,
    {{ json_extract_scalar('_airbyte_data', ['remember_created_at'], ['remember_created_at']) }} as remember_created_at,
    {{ json_extract_scalar('_airbyte_data', ['confirmation_sent_at'], ['confirmation_sent_at']) }} as confirmation_sent_at,
    {{ json_extract_scalar('_airbyte_data', ['custom_fields_enabled'], ['custom_fields_enabled']) }} as custom_fields_enabled,
    {{ json_extract_scalar('_airbyte_data', ['reset_password_sent_at'], ['reset_password_sent_at']) }} as reset_password_sent_at,
    {{ json_extract_scalar('_airbyte_data', ['salesforce_last_update'], ['salesforce_last_update']) }} as salesforce_last_update,
    {{ json_extract_scalar('_airbyte_data', ['current_page_wrapper_id'], ['current_page_wrapper_id']) }} as current_page_wrapper_id,
    {{ json_extract_scalar('_airbyte_data', ['email_templates_enabled'], ['email_templates_enabled']) }} as email_templates_enabled,
    {{ json_extract_scalar('_airbyte_data', ['salesforce_sync_enabled'], ['salesforce_sync_enabled']) }} as salesforce_sync_enabled,
    {{ json_extract_scalar('_airbyte_data', ['salesforce_custom_fields'], ['salesforce_custom_fields']) }} as salesforce_custom_fields,
    {{ json_extract_scalar('_airbyte_data', ['credit_card_last_4_digits'], ['credit_card_last_4_digits']) }} as credit_card_last_4_digits,
    {{ json_extract_scalar('_airbyte_data', ['current_email_template_id'], ['current_email_template_id']) }} as current_email_template_id,
    {{ json_extract_scalar('_airbyte_data', ['salesforce_sync_successful'], ['salesforce_sync_successful']) }} as salesforce_sync_successful,
    {{ json_extract_scalar('_airbyte_data', ['receive_transactional_email'], ['receive_transactional_email']) }} as receive_transactional_email,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_users') }} as table_alias
-- users
where 1 = 1

