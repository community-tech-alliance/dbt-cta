{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('groups_users_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(hidden as {{ dbt_utils.type_bigint() }}) as hidden,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(approved as {{ dbt_utils.type_bigint() }}) as approved,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(is_leader as {{ dbt_utils.type_bigint() }}) as is_leader,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(first_visit as {{ dbt_utils.type_bigint() }}) as first_visit,
    cast(join_message as {{ dbt_utils.type_string() }}) as join_message,
    cast(user_permissions as {{ dbt_utils.type_string() }}) as user_permissions,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('groups_users_ab1') }}
-- groups_users
where 1 = 1

