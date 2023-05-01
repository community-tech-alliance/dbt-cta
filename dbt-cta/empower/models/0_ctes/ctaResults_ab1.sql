{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_ctaResults') }}
select
    {{ json_extract_scalar('_airbyte_data', ['profileEid'], ['profileEid']) }} as profileEid,
    {{ json_extract_scalar('_airbyte_data', ['ctaId'], ['ctaId']) }} as ctaId,
    {{ json_extract_scalar('_airbyte_data', ['notes'], ['notes']) }} as notes,
    {{ json_extract_scalar('_airbyte_data', ['contactedMts'], ['contactedMts']) }} as contactedMts,
    {{ json_extract('table_alias', '_airbyte_data', ['answers'], ['answers']) }} as answers,
    {{ json_extract('table_alias', '_airbyte_data', ['answerIdsByPromptId'], ['answerIdsByPromptId']) }} as answerIdsByPromptId,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_ctaResults') }} as table_alias
where 1 = 1

