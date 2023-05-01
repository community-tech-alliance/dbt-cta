{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('ctas_prompts_answers_ab1') }}
select
    _airbyte_prompts_hashid,
    cast(vanId as {{ dbt_utils.type_bigint() }}) as vanId,
    {{ cast_to_boolean('isDeleted') }} as isDeleted,
    cast(answerText as {{ dbt_utils.type_string() }}) as answerText,
    cast(ordering as {{ dbt_utils.type_bigint() }}) as ordering,
    cast(promptId as {{ dbt_utils.type_bigint() }}) as promptId,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ctas_prompts_answers_ab1') }}
-- answers at ctas/prompts/answers
where 1 = 1

