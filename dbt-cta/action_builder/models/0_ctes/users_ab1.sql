{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_users') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['uid'], ['uid']) }} as uid,
    {{ json_extract_scalar('_airbyte_data', ['role'], ['role']) }} as role,
    {{ json_extract_scalar('_airbyte_data', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('_airbyte_data', ['tokens'], ['tokens']) }} as tokens,
    {{ json_extract_scalar('_airbyte_data', ['provider'], ['provider']) }} as provider,
    {{ json_extract_scalar('_airbyte_data', ['last_name'], ['last_name']) }} as last_name,
    {{ json_extract_scalar('_airbyte_data', ['api_access'], ['api_access']) }} as api_access,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['deleted_at'], ['deleted_at']) }} as deleted_at,
    {{ json_extract_scalar('_airbyte_data', ['disable_on'], ['disable_on']) }} as disable_on,
    {{ json_extract_scalar('_airbyte_data', ['first_name'], ['first_name']) }} as first_name,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['confirmed_at'], ['confirmed_at']) }} as confirmed_at,
    {{ json_extract_scalar('_airbyte_data', ['phone_number'], ['phone_number']) }} as phone_number,
    {{ json_extract_scalar('_airbyte_data', ['invited_by_id'], ['invited_by_id']) }} as invited_by_id,
    {{ json_extract_scalar('_airbyte_data', ['sign_in_count'], ['sign_in_count']) }} as sign_in_count,
    {{ json_extract_scalar('_airbyte_data', ['invited_by_type'], ['invited_by_type']) }} as invited_by_type,
    {{ json_extract_scalar('_airbyte_data', ['last_sign_in_at'], ['last_sign_in_at']) }} as last_sign_in_at,
    {{ json_extract_scalar('_airbyte_data', ['last_sign_in_ip'], ['last_sign_in_ip']) }} as last_sign_in_ip,
    {{ json_extract_scalar('_airbyte_data', ['invitation_limit'], ['invitation_limit']) }} as invitation_limit,
    {{ json_extract_scalar('_airbyte_data', ['invitation_token'], ['invitation_token']) }} as invitation_token,
    {{ json_extract_scalar('_airbyte_data', ['invitations_count'], ['invitations_count']) }} as invitations_count,
    {{ json_extract_scalar('_airbyte_data', ['unconfirmed_email'], ['unconfirmed_email']) }} as unconfirmed_email,
    {{ json_extract_scalar('_airbyte_data', ['confirmation_token'], ['confirmation_token']) }} as confirmation_token,
    {{ json_extract_scalar('_airbyte_data', ['current_sign_in_at'], ['current_sign_in_at']) }} as current_sign_in_at,
    {{ json_extract_scalar('_airbyte_data', ['current_sign_in_ip'], ['current_sign_in_ip']) }} as current_sign_in_ip,
    {{ json_extract_scalar('_airbyte_data', ['encrypted_password'], ['encrypted_password']) }} as encrypted_password,
    {{ json_extract_scalar('_airbyte_data', ['invitation_sent_at'], ['invitation_sent_at']) }} as invitation_sent_at,
    {{ json_extract_scalar('_airbyte_data', ['remember_created_at'], ['remember_created_at']) }} as remember_created_at,
    {{ json_extract_scalar('_airbyte_data', ['authentication_token'], ['authentication_token']) }} as authentication_token,
    {{ json_extract_scalar('_airbyte_data', ['confirmation_sent_at'], ['confirmation_sent_at']) }} as confirmation_sent_at,
    {{ json_extract_scalar('_airbyte_data', ['reset_password_token'], ['reset_password_token']) }} as reset_password_token,
    {{ json_extract_scalar('_airbyte_data', ['allow_password_change'], ['allow_password_change']) }} as allow_password_change,
    {{ json_extract_scalar('_airbyte_data', ['invitation_created_at'], ['invitation_created_at']) }} as invitation_created_at,
    {{ json_extract_scalar('_airbyte_data', ['invitation_accepted_at'], ['invitation_accepted_at']) }} as invitation_accepted_at,
    {{ json_extract_scalar('_airbyte_data', ['reset_password_sent_at'], ['reset_password_sent_at']) }} as reset_password_sent_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_users') }}
-- users
where 1 = 1
