{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_message_actions') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['referrer'], ['referrer']) }} as referrer,
    {{ json_extract_scalar('_airbyte_data', ['action_id'], ['action_id']) }} as action_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['sending_id'], ['sending_id']) }} as sending_id,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['action_type'], ['action_type']) }} as action_type,
    {{ json_extract_scalar('_airbyte_data', ['sending_type'], ['sending_type']) }} as sending_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_message_actions') }} as table_alias
-- message_actions
where 1 = 1

