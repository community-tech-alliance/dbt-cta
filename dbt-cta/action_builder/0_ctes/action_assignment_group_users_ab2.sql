{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('action_assignment_group_users_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(end_address_id as {{ dbt_utils.type_bigint() }}) as end_address_id,
    cast(start_address_id as {{ dbt_utils.type_bigint() }}) as start_address_id,
    {{ cast_to_boolean('exclude_completed_actions') }} as exclude_completed_actions,
    cast(action_assignment_group_id as {{ dbt_utils.type_bigint() }}) as action_assignment_group_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('action_assignment_group_users_ab1') }}
-- action_assignment_group_users
where 1 = 1

