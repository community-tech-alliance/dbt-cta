{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_conversations') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['body'], ['body']) }} as body,
    {{ json_extract_scalar('_airbyte_data', ['source'], ['source']) }} as source,
    {{ json_extract_scalar('_airbyte_data', ['private'], ['private']) }} as private,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['category'], ['category']) }} as category,
    {{ json_extract_scalar('_airbyte_data', ['incoming'], ['incoming']) }} as incoming,
    {{ json_extract_scalar('_airbyte_data', ['body_text'], ['body_text']) }} as body_text,
    {{ json_extract_array('_airbyte_data', ['cc_emails'], ['cc_emails']) }} as cc_emails,
    {{ json_extract_scalar('_airbyte_data', ['ticket_id'], ['ticket_id']) }} as ticket_id,
    {{ json_extract_array('_airbyte_data', ['to_emails'], ['to_emails']) }} as to_emails,
    {{ json_extract_array('_airbyte_data', ['bcc_emails'], ['bcc_emails']) }} as bcc_emails,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['from_email'], ['from_email']) }} as from_email,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_array('_airbyte_data', ['attachments'], ['attachments']) }} as attachments,
    {{ json_extract_scalar('_airbyte_data', ['support_email'], ['support_email']) }} as support_email,
    {{ json_extract('table_alias', '_airbyte_data', ['source_additional_info'], ['source_additional_info']) }} as source_additional_info,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_conversations') }} as table_alias
-- conversations
where 1 = 1

