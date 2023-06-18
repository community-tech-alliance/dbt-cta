{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_phone_banking_responses') }}
select
    {{ json_extract_scalar('_airbyte_data', ['answer_option_id'], ['answer_option_id']) }} as answer_option_id,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['question_id'], ['question_id']) }} as question_id,
    {{ json_extract_scalar('_airbyte_data', ['call_id'], ['call_id']) }} as call_id,
    {{ json_extract_scalar('_airbyte_data', ['open_ended_answer_text'], ['open_ended_answer_text']) }} as open_ended_answer_text,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_phone_banking_responses') }} as table_alias
-- phone_banking_responses
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

