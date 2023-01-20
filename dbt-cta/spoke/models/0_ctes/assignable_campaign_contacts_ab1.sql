{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_assignable_campaign_contacts') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['campaign_id'], ['campaign_id']) }} as campaign_id,
    {{ json_extract_scalar('_airbyte_data', ['message_status'], ['message_status']) }} as message_status,
    {{ json_extract_scalar('_airbyte_data', ['contact_timezone'], ['contact_timezone']) }} as contact_timezone,
    {{ json_extract_scalar('_airbyte_data', ['texting_hours_end'], ['texting_hours_end']) }} as texting_hours_end,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_assignable_campaign_contacts') }} as table_alias
-- assignable_campaign_contacts
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

