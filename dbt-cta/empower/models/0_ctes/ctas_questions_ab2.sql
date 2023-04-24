{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('ctas_questions_ab1') }}
select
    _airbyte_ctas_hashid,
    cast(surveyQuestionVanId as {{ dbt_utils.type_bigint() }}) as surveyQuestionVanId,
    values,
    options,
    cast(text as {{ dbt_utils.type_string() }}) as text,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(key as {{ dbt_utils.type_bigint() }}) as key,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ctas_questions_ab1') }}
-- questions at ctas/questions
where 1 = 1

