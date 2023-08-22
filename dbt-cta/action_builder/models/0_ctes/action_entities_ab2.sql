{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('action_entities_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(action_id as {{ dbt_utils.type_bigint() }}) as action_id,
    cast(entity_id as {{ dbt_utils.type_bigint() }}) as entity_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast({{ empty_string_to_null('completed_at') }} as {{ type_timestamp_without_timezone() }}) as completed_at,
    cast(pending_count as {{ dbt_utils.type_bigint() }}) as pending_count,
    cast(completed_count as {{ dbt_utils.type_bigint() }}) as completed_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('action_entities_ab1') }}
-- action_entities
where 1 = 1
