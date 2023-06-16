{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('sv_blocks', '_airbyte_raw_quality_control_phone_verification_question_translations') }}
select
    {{ json_extract_scalar('_airbyte_data', ['translation_text'], ['translation_text']) }} as translation_text,
    {{ json_extract_scalar('_airbyte_data', ['script_id'], ['script_id']) }} as script_id,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['question_id'], ['question_id']) }} as question_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('sv_blocks', '_airbyte_raw_quality_control_phone_verification_question_translations') }} as table_alias
-- quality_control_phone_verification_question_translations
where 1 = 1

