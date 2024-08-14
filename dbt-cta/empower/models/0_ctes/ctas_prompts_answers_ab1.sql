{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('ctas_prompts_base') }}
{{ unnest_cte(ref('ctas_prompts'), 'prompts', 'answers') }}
select
    _airbyte_prompts_hashid,
    {{ json_extract_scalar(unnested_column_value('answers'), ['vanId'], ['vanId']) }} as vanId,
    {{ json_extract_scalar(unnested_column_value('answers'), ['isDeleted'], ['isDeleted']) }} as isDeleted,
    {{ json_extract_scalar(unnested_column_value('answers'), ['answerText'], ['answerText']) }} as answerText,
    {{ json_extract_scalar(unnested_column_value('answers'), ['ordering'], ['ordering']) }} as ordering,
    {{ json_extract_scalar(unnested_column_value('answers'), ['promptId'], ['promptId']) }} as promptId,
    {{ json_extract_scalar(unnested_column_value('answers'), ['id'], ['id']) }} as id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ctas_prompts_base') }}
{{ cross_join_unnest('prompts', 'answers') }}
where
    1 = 1
    and answers is not null
