{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('freshdesk_partner_a', '_airbyte_raw_email_mailboxes') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['port'], ['port']) }} as port,
    {{ json_extract_scalar('_airbyte_data', ['use_ssl'], ['use_ssl']) }} as use_ssl,
    {{ json_extract_scalar('_airbyte_data', ['group_id'], ['group_id']) }} as group_id,
    {{ json_extract_scalar('_airbyte_data', ['incoming'], ['incoming']) }} as incoming,
    {{ json_extract_scalar('_airbyte_data', ['password'], ['password']) }} as password,
    {{ json_extract_scalar('_airbyte_data', ['username'], ['username']) }} as username,
    {{ json_extract_scalar('_airbyte_data', ['product_id'], ['product_id']) }} as product_id,
    {{ json_extract_scalar('_airbyte_data', ['access_type'], ['access_type']) }} as access_type,
    {{ json_extract_scalar('_airbyte_data', ['mail_server'], ['mail_server']) }} as mail_server,
    {{ json_extract_scalar('_airbyte_data', ['mailbox_type'], ['mailbox_type']) }} as mailbox_type,
    {{ json_extract_scalar('_airbyte_data', ['support_email'], ['support_email']) }} as support_email,
    {{ json_extract_scalar('_airbyte_data', ['authentication'], ['authentication']) }} as authentication,
    {{ json_extract_scalar('_airbyte_data', ['custom_mailbox'], ['custom_mailbox']) }} as custom_mailbox,
    {{ json_extract_scalar('_airbyte_data', ['delete_from_server'], ['delete_from_server']) }} as delete_from_server,
    {{ json_extract_scalar('_airbyte_data', ['default_reply_email'], ['default_reply_email']) }} as default_reply_email,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('freshdesk_partner_a', '_airbyte_raw_email_mailboxes') }} as table_alias
-- email_mailboxes
where 1 = 1

