{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_action_questions') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['required'], ['required']) }} as required,
    {{ json_extract_scalar('_airbyte_data', ['action_id'], ['action_id']) }} as action_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['action_type'], ['action_type']) }} as action_type,
    {{ json_extract_scalar('_airbyte_data', ['custom_json'], ['custom_json']) }} as custom_json,
    {{ json_extract_scalar('_airbyte_data', ['question_id'], ['question_id']) }} as question_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_action_questions') }}
-- action_questions
where 1 = 1
