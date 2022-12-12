{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('surveys_questions_ab1') }}
select
    survey_id,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(label as {{ dbt_utils.type_string() }}) as label,
    {{ cast_to_boolean(adapter.quote('default')) }} as {{ adapter.quote('default') }},
    accepted_ratings,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('surveys_questions_ab1') }}
-- questions at surveys/questions
where 1 = 1

