{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('entity_connection_types_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(interact_id as {{ dbt_utils.type_string() }}) as interact_id,
    cast(created_by_id as {{ dbt_utils.type_bigint() }}) as created_by_id,
    cast(updated_by_id as {{ dbt_utils.type_bigint() }}) as updated_by_id,
    cast(display_position as {{ dbt_utils.type_bigint() }}) as display_position,
    cast(entity_type_1_id as {{ dbt_utils.type_bigint() }}) as entity_type_1_id,
    cast(entity_type_2_id as {{ dbt_utils.type_bigint() }}) as entity_type_2_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('entity_connection_types_ab1') }}
-- entity_connection_types
where 1 = 1

