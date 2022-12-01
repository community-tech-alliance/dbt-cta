{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('shifts_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(wage as {{ type_json() }}) as wage,
    breaks,
    cast(end_at as {{ dbt_utils.type_string() }}) as end_at,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(version as {{ dbt_utils.type_bigint() }}) as version,
    cast(start_at as {{ dbt_utils.type_string() }}) as start_at,
    cast(timezone as {{ dbt_utils.type_string() }}) as timezone,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(employee_id as {{ dbt_utils.type_string() }}) as employee_id,
    cast(location_id as {{ dbt_utils.type_string() }}) as location_id,
    cast(team_member_id as {{ dbt_utils.type_string() }}) as team_member_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('shifts_ab1') }}
-- shifts
where 1 = 1

