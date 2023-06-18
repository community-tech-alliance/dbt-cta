{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('schedules_ab1') }}
select
    cast({{ empty_string_to_null('date') }} as {{ type_date() }}) as date,
    cast(count as {{ dbt_utils.type_bigint() }}) as count,
    cast(rule as {{ dbt_utils.type_string() }}) as rule,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(schedulable_type as {{ dbt_utils.type_string() }}) as schedulable_type,
    cast(schedulable_id as {{ dbt_utils.type_bigint() }}) as schedulable_id,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(until as {{ dbt_utils.type_string() }}) as until,
    cast({{ adapter.quote('interval') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('interval') }},
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(time as {{ dbt_utils.type_string() }}) as `time`,
    cast(day as {{ dbt_utils.type_string() }}) as day,
    cast(day_of_week as {{ dbt_utils.type_string() }}) as day_of_week,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('schedules_ab1') }}
-- schedules
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

