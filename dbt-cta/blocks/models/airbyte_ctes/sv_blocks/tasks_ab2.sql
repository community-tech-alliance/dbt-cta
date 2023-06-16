{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('tasks_ab1') }}
select
    cast(taskable_type as {{ dbt_utils.type_string() }}) as taskable_type,
    cast(taskable_id as {{ dbt_utils.type_bigint() }}) as taskable_id,
    cast(assignee_type as {{ dbt_utils.type_string() }}) as assignee_type,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(assignee_id as {{ dbt_utils.type_bigint() }}) as assignee_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('tasks_ab1') }}
-- tasks
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

