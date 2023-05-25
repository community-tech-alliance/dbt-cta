{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('networks_users_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(user_id as {{ dbt_utils.type_string() }}) as user_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(network_id as {{ dbt_utils.type_string() }}) as network_id,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(accepted_terms as {{ dbt_utils.type_bigint() }}) as accepted_terms,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('networks_users_ab1') }}
-- networks_users
where 1 = 1

