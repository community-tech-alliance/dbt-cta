{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('admin_users_ab1') }}
select
    cast(session as {{ dbt_utils.type_string() }}) as session,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(encrypted_password as {{ dbt_utils.type_string() }}) as encrypted_password,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('admin_users_ab1') }}
-- admin_users
where 1 = 1

