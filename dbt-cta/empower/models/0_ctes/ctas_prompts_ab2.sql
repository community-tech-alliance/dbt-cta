{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_empower_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('ctas_prompts_ab1') }}
select
    _airbyte_ctas_hashid,
    cast(ctaId as {{ dbt_utils.type_bigint() }}) as ctaId,
    cast(vanId as {{ dbt_utils.type_bigint() }}) as vanId,
    {{ cast_to_boolean('isDeleted') }} as isDeleted,
    cast(ordering as {{ dbt_utils.type_bigint() }}) as ordering,
    answers,
    cast(answerInputType as {{ dbt_utils.type_string() }}) as answerInputType,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(promptText as {{ dbt_utils.type_string() }}) as promptText,
    dependsOnInitialDispositionResponse,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ctas_prompts_ab1') }}
-- prompts at ctas/prompts
where 1 = 1

