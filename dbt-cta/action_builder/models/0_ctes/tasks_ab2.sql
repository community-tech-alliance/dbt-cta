{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('tasks_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    {{ cast_to_boolean('resolved') }} as resolved,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(object_ref as {{ dbt_utils.type_bigint() }}) as object_ref,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast({{ empty_string_to_null('resolved_at') }} as {{ type_timestamp_without_timezone() }}) as resolved_at,
    cast(resolved_by_id as {{ dbt_utils.type_bigint() }}) as resolved_by_id,
    cast(action_field_id as {{ dbt_utils.type_bigint() }}) as action_field_id,
    cast(action_entity_id as {{ dbt_utils.type_bigint() }}) as action_entity_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('tasks_ab1') }}
-- tasks
where 1 = 1

