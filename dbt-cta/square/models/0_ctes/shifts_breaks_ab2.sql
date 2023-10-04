{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('shifts_breaks_ab1') }}
select
    _airbyte_shifts_hashid,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(end_at as {{ dbt_utils.type_string() }}) as end_at,
    {{ cast_to_boolean('is_paid') }} as is_paid,
    cast(start_at as {{ dbt_utils.type_string() }}) as start_at,
    cast(break_type_id as {{ dbt_utils.type_string() }}) as break_type_id,
    cast(expected_duration as {{ dbt_utils.type_string() }}) as expected_duration,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('shifts_breaks_ab1') }}
-- breaks at shifts/breaks
where 1 = 1
