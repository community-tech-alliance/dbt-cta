{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('group_growth_by_source_codes_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(end_at as {{ dbt_utils.type_string() }}) as end_at,
    cast(group_id as {{ dbt_utils.type_bigint() }}) as group_id,
    cast(start_at as {{ dbt_utils.type_string() }}) as start_at,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(source_code as {{ dbt_utils.type_string() }}) as source_code,
    cast(total_count as {{ dbt_utils.type_bigint() }}) as total_count,
    cast(new_users_count as {{ dbt_utils.type_bigint() }}) as new_users_count,
    cast(last_subscription_id as {{ dbt_utils.type_bigint() }}) as last_subscription_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('group_growth_by_source_codes_ab1') }}
-- group_growth_by_source_codes
where 1 = 1
