{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_interaction_step') }}
select
    {{ json_extract_scalar('_airbyte_data', ['answer_actions_data'], ['answer_actions_data']) }} as answer_actions_data,
    {{ json_extract_scalar('_airbyte_data', ['is_deleted'], ['is_deleted']) }} as is_deleted,
    {{ json_extract_scalar('_airbyte_data', ['question'], ['question']) }} as question,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['answer_actions'], ['answer_actions']) }} as answer_actions,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['answer_option'], ['answer_option']) }} as answer_option,
    {{ json_extract_scalar('_airbyte_data', ['parent_interaction_id'], ['parent_interaction_id']) }} as parent_interaction_id,
    {{ json_extract_scalar('_airbyte_data', ['script'], ['script']) }} as script,
    {{ json_extract_scalar('_airbyte_data', ['campaign_id'], ['campaign_id']) }} as campaign_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_interaction_step') }} as table_alias
-- interaction_step
where 1 = 1


