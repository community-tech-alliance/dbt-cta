{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('survey_base') }}
{{ unnest_cte(ref('survey_base'), 'survey_base', 'questions') }}
select
    id as survey_id,
    {{ json_extract_scalar(unnested_column_value('questions'), ['id'], ['id']) }} as id,
    {{ json_extract_scalar(unnested_column_value('questions'), ['label'], ['label']) }} as label,
    {{ json_extract_scalar(unnested_column_value('questions'), ['default'], ['default']) }} as {{ adapter.quote('default') }},
    {{ json_extract_string_array(unnested_column_value('questions'), ['accepted_ratings'], ['accepted_ratings']) }} as accepted_ratings,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('survey_base') }} as table_alias
-- questions at survey_base/questions
{{ cross_join_unnest('survey_base', 'questions') }}
where 1 = 1
and questions is not null

