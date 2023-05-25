{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('steps_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(uuid as {{ dbt_utils.type_string() }}) as uuid,
    cast(rules as {{ dbt_utils.type_string() }}) as rules,
    cast(ladder_id as {{ dbt_utils.type_bigint() }}) as ladder_id,
    cast(step_type as {{ dbt_utils.type_string() }}) as step_type,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(next_step_id as {{ dbt_utils.type_string() }}) as next_step_id,
    cast(alternate_next_step_id as {{ dbt_utils.type_string() }}) as alternate_next_step_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('steps_ab1') }}
-- steps
where 1 = 1

