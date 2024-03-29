{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('organization_memberships_ab1') }}
select
    cast(member_id as {{ dbt_utils.type_bigint() }}) as member_id,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(responsibility as {{ dbt_utils.type_string() }}) as responsibility,
    cast(organization_id as {{ dbt_utils.type_bigint() }}) as organization_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(responsibility_id as {{ dbt_utils.type_bigint() }}) as responsibility_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('organization_memberships_ab1') }}
-- organization_memberships
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

