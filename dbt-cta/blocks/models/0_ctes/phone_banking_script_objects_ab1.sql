{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_phone_banking_script_objects') }}
select
    {{ json_extract_scalar('_airbyte_data', ['is_section_divider'], ['is_section_divider']) }} as is_section_divider,
    {{ json_extract_scalar('_airbyte_data', ['scriptable_id'], ['scriptable_id']) }} as scriptable_id,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['scriptable_type'], ['scriptable_type']) }} as scriptable_type,
    {{ json_extract_scalar('_airbyte_data', ['script_id'], ['script_id']) }} as script_id,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['question_id'], ['question_id']) }} as question_id,
    {{ json_extract_scalar('_airbyte_data', ['position_in_script'], ['position_in_script']) }} as position_in_script,
    {{ json_extract_scalar('_airbyte_data', ['script_text_id'], ['script_text_id']) }} as script_text_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_phone_banking_script_objects') }}
-- phone_banking_script_objects
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

