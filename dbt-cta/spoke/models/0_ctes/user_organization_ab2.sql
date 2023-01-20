{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('user_organization_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(role as {{ dbt_utils.type_string() }}) as role,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_with_timezone() }}) as updated_at,
    cast(request_status as {{ dbt_utils.type_string() }}) as request_status,
    cast(organization_id as {{ dbt_utils.type_bigint() }}) as organization_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('user_organization_ab1') }}
-- user_organization
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

