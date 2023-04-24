{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('ctaresults_answers_ab1') }}
select
    _airbyte_ctaresults_hashid,
    cast(_11 as {{ dbt_utils.type_string() }}) as _11,
    cast(_1 as {{ dbt_utils.type_string() }}) as _1,
    cast(_10 as {{ dbt_utils.type_string() }}) as _10,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ctaresults_answers_ab1') }}
-- answers at ctaresults/answers
where 1 = 1

