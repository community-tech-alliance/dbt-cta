{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_pending_message_part') }}
select
    {{ json_extract_scalar('_airbyte_data', ['service'], ['service']) }} as service,
    {{ json_extract_scalar('_airbyte_data', ['parent_id'], ['parent_id']) }} as parent_id,
    {{ json_extract_scalar('_airbyte_data', ['service_id'], ['service_id']) }} as service_id,
    {{ json_extract_scalar('_airbyte_data', ['service_message'], ['service_message']) }} as service_message,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['contact_number'], ['contact_number']) }} as contact_number,
    {{ json_extract_scalar('_airbyte_data', ['user_number'], ['user_number']) }} as user_number,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_pending_message_part') }} as table_alias
-- pending_message_part
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

