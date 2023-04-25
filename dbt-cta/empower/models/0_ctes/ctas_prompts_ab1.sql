{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('ctas_base') }}
{{ unnest_cte(ref('ctas_base'), 'ctas', 'prompts') }}
select
    _airbyte_ctas_hashid,
    {{ json_extract_scalar(unnested_column_value('prompts'), ['ctaId'], ['ctaId']) }} as ctaId,
    {{ json_extract_scalar(unnested_column_value('prompts'), ['vanId'], ['vanId']) }} as vanId,
    {{ json_extract_scalar(unnested_column_value('prompts'), ['isDeleted'], ['isDeleted']) }} as isDeleted,
    {{ json_extract_scalar(unnested_column_value('prompts'), ['ordering'], ['ordering']) }} as ordering,
    {{ json_extract_array(unnested_column_value('prompts'), ['answers'], ['answers']) }} as answers,
    {{ json_extract_scalar(unnested_column_value('prompts'), ['answerInputType'], ['answerInputType']) }} as answerInputType,
    {{ json_extract_scalar(unnested_column_value('prompts'), ['id'], ['id']) }} as id,
    {{ json_extract_scalar(unnested_column_value('prompts'), ['promptText'], ['promptText']) }} as promptText,
    {{ json_extract('', unnested_column_value('prompts'), ['dependsOnInitialDispositionResponse']) }} as dependsOnInitialDispositionResponse,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ctas_base') }} as table_alias
{{ cross_join_unnest('ctas_base', 'prompts') }}
where 1 = 1
and prompts is not null

