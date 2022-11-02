{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_tickets') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['spam'], ['spam']) }} as spam,
    {{ json_extract_array('_airbyte_data', ['tags'], ['tags']) }} as tags,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as type,
    {{ json_extract('table_alias', '_airbyte_data', ['stats'], ['stats']) }} as stats,
    {{ json_extract_scalar('_airbyte_data', ['due_by'], ['due_by']) }} as due_by,
    {{ json_extract_scalar('_airbyte_data', ['source'], ['source']) }} as source,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['subject'], ['subject']) }} as subject,
    {{ json_extract_scalar('_airbyte_data', ['group_id'], ['group_id']) }} as group_id,
    {{ json_extract_scalar('_airbyte_data', ['priority'], ['priority']) }} as priority,
    {{ json_extract_array('_airbyte_data', ['cc_emails'], ['cc_emails']) }} as cc_emails,
    {{ json_extract_scalar('_airbyte_data', ['fr_due_by'], ['fr_due_by']) }} as fr_due_by,
    {{ json_extract_scalar('_airbyte_data', ['nr_due_by'], ['nr_due_by']) }} as nr_due_by,
    {{ json_extract('table_alias', '_airbyte_data', ['requester'], ['requester']) }} as requester,
    {{ json_extract_string_array('_airbyte_data', ['to_emails'], ['to_emails']) }} as to_emails,
    {{ json_extract_scalar('_airbyte_data', ['company_id'], ['company_id']) }} as company_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_array('_airbyte_data', ['fwd_emails'], ['fwd_emails']) }} as fwd_emails,
    {{ json_extract_scalar('_airbyte_data', ['product_id'], ['product_id']) }} as product_id,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['fr_escalated'], ['fr_escalated']) }} as fr_escalated,
    {{ json_extract_scalar('_airbyte_data', ['is_escalated'], ['is_escalated']) }} as is_escalated,
    {{ json_extract_scalar('_airbyte_data', ['nr_escalated'], ['nr_escalated']) }} as nr_escalated,
    {{ json_extract_scalar('_airbyte_data', ['requester_id'], ['requester_id']) }} as requester_id,
    {{ json_extract_scalar('_airbyte_data', ['responder_id'], ['responder_id']) }} as responder_id,
    {{ json_extract('table_alias', '_airbyte_data', ['custom_fields'], ['custom_fields']) }} as custom_fields,
    {{ json_extract_scalar('_airbyte_data', ['email_config_id'], ['email_config_id']) }} as email_config_id,
    {{ json_extract_array('_airbyte_data', ['reply_cc_emails'], ['reply_cc_emails']) }} as reply_cc_emails,
    {{ json_extract_scalar('_airbyte_data', ['association_type'], ['association_type']) }} as association_type,
    {{ json_extract_scalar('_airbyte_data', ['description_text'], ['description_text']) }} as description_text,
    {{ json_extract_array('_airbyte_data', ['ticket_cc_emails'], ['ticket_cc_emails']) }} as ticket_cc_emails,
    {{ json_extract_scalar('_airbyte_data', ['associated_tickets_count'], ['associated_tickets_count']) }} as associated_tickets_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_tickets') }} as table_alias
-- tickets
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

