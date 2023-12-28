{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('field_management_goals_ab1') }}
select
    cast({{ empty_string_to_null('end_date') }} as {{ type_date() }}) as end_date,
    cast(turf_id as {{ dbt_utils.type_bigint() }}) as turf_id,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(targets as {{ dbt_utils.type_string() }}) as targets,
    cast(labels as {{ dbt_utils.type_string() }}) as labels,
    cast({{ empty_string_to_null('start_date') }} as {{ type_date() }}) as start_date,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('field_management_goals_ab1') }}
-- field_management_goals
where 1 = 1
