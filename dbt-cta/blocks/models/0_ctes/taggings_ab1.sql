{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_taggings') }}
select
    {{ json_extract_scalar('_airbyte_data', ['context'], ['context']) }} as context,
    {{ json_extract_scalar('_airbyte_data', ['tag_id'], ['tag_id']) }} as tag_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['tagger_type'], ['tagger_type']) }} as tagger_type,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['phone_banking_question_id'], ['phone_banking_question_id']) }} as phone_banking_question_id,
    {{ json_extract_scalar('_airbyte_data', ['taggable_id'], ['taggable_id']) }} as taggable_id,
    {{ json_extract_scalar('_airbyte_data', ['tagger_id'], ['tagger_id']) }} as tagger_id,
    {{ json_extract_scalar('_airbyte_data', ['taggable_type'], ['taggable_type']) }} as taggable_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_taggings') }}
-- taggings
where 1 = 1
