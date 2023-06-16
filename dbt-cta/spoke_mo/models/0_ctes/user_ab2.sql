{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('user_ab1') }}
select
    {{ cast_to_boolean('terms') }} as terms,
    cast(extra as {{ dbt_utils.type_string() }}) as extra,
    cast(assigned_cell as {{ dbt_utils.type_string() }}) as assigned_cell,
    cast(alias as {{ dbt_utils.type_string() }}) as alias,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(cell as {{ dbt_utils.type_string() }}) as cell,
    cast(auth0_id as {{ dbt_utils.type_string() }}) as auth0_id,
    {{ cast_to_boolean('is_superadmin') }} as is_superadmin,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('user_ab1') }}
-- user
where 1 = 1


