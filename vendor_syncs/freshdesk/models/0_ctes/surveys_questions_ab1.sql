{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('surveys') }}
{{ unnest_cte(ref('surveys'), 'surveys', 'questions') }}
select
    _airbyte_surveys_hashid,
    {{ json_extract_scalar(unnested_column_value('questions'), ['id'], ['id']) }} as id,
    {{ json_extract_scalar(unnested_column_value('questions'), ['label'], ['label']) }} as label,
    {{ json_extract_scalar(unnested_column_value('questions'), ['default'], ['default']) }} as {{ adapter.quote('default') }},
    {{ json_extract_string_array(unnested_column_value('questions'), ['accepted_ratings'], ['accepted_ratings']) }} as accepted_ratings,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('surveys') }} as table_alias
-- questions at surveys/questions
{{ cross_join_unnest('surveys', 'questions') }}
where 1 = 1
and questions is not null

