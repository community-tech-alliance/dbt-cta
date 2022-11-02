{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('time_entries_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(note as {{ dbt_utils.type_string() }}) as note,
    cast(agent_id as {{ dbt_utils.type_bigint() }}) as agent_id,
    {{ cast_to_boolean('billable') }} as billable,
    cast(ticket_id as {{ dbt_utils.type_bigint() }}) as ticket_id,
    cast(company_id as {{ dbt_utils.type_bigint() }}) as company_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(start_time as {{ dbt_utils.type_string() }}) as start_time,
    cast(time_spent as {{ dbt_utils.type_string() }}) as time_spent,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(executed_at as {{ dbt_utils.type_string() }}) as executed_at,
    {{ cast_to_boolean('timer_running') }} as timer_running,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('time_entries_ab1') }}
-- time_entries
where 1 = 1

