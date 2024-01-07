{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('check_in_questions_ab1') }}
select
    {{ cast_to_boolean('archived') }} as archived,
    cast(check_in_id as {{ dbt_utils.type_bigint() }}) as check_in_id,
    cast(turf_id as {{ dbt_utils.type_bigint() }}) as turf_id,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(text as {{ dbt_utils.type_string() }}) as text,
    cast(position as {{ dbt_utils.type_bigint() }}) as position,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('check_in_questions_ab1') }}
-- check_in_questions
where 1 = 1
