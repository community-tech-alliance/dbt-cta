{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('ctas_base') }}
{{ unnest_cte(ref('ctas'), 'ctas', 'questions') }}
select
    _airbyte_ctas_hashid,
    {{ json_extract_scalar(unnested_column_value('questions'), ['surveyQuestionVanId'], ['surveyQuestionVanId']) }} as surveyQuestionVanId,
    {{ json_extract_string_array(unnested_column_value('questions'), ['values'], ['values']) }} as values,
    {{ json_extract_string_array(unnested_column_value('questions'), ['options'], ['options']) }} as options,
    {{ json_extract_scalar(unnested_column_value('questions'), ['text'], ['text']) }} as text,
    {{ json_extract_scalar(unnested_column_value('questions'), ['type'], ['type']) }} as type,
    {{ json_extract_scalar(unnested_column_value('questions'), ['key'], ['key']) }} as key,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ctas_base') }} as table_alias
{{ cross_join_unnest('ctas', 'questions') }}
where 1 = 1
and questions is not null

