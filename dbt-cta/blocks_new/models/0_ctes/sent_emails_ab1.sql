{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_sent_emails') }}
select
    {{ json_extract_scalar('_airbyte_data', ['recipients_count'], ['recipients_count']) }} as recipients_count,
    {{ json_extract_scalar('_airbyte_data', ['event_id'], ['event_id']) }} as event_id,
    {{ json_extract_scalar('_airbyte_data', ['list_id'], ['list_id']) }} as list_id,
    {{ json_extract_scalar('_airbyte_data', ['email_template_id'], ['email_template_id']) }} as email_template_id,
    {{ json_extract_scalar('_airbyte_data', ['subject'], ['subject']) }} as subject,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['from'], ['from']) }} as {{ adapter.quote('from') }},
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['team_id'], ['team_id']) }} as team_id,
    {{ json_extract_scalar('_airbyte_data', ['body'], ['body']) }} as body,
    {{ json_extract_scalar('_airbyte_data', ['sender_id'], ['sender_id']) }} as sender_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_sent_emails') }} as table_alias
-- sent_emails
where 1 = 1

