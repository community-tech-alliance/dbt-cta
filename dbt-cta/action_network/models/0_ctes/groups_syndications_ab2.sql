{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('groups_syndications_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(read as {{ dbt_utils.type_bigint() }}) as read,
    cast(email_id as {{ dbt_utils.type_bigint() }}) as email_id,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(notified as {{ dbt_utils.type_bigint() }}) as notified,
    cast(action_id as {{ dbt_utils.type_bigint() }}) as action_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(action_type as {{ dbt_utils.type_string() }}) as action_type,
    cast(syndication_id as {{ dbt_utils.type_bigint() }}) as syndication_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('groups_syndications_ab1') }}
-- groups_syndications
where 1 = 1

