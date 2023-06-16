{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('roles_ab1') }}
select
    {{ cast_to_boolean('needs_training') }} as needs_training,
    {{ cast_to_boolean('admin') }} as admin,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(abilities as {{ dbt_utils.type_string() }}) as abilities,
    cast(depth as {{ dbt_utils.type_bigint() }}) as depth,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(parent_id as {{ dbt_utils.type_bigint() }}) as parent_id,
    cast(permissions as {{ dbt_utils.type_string() }}) as permissions,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(lft as {{ dbt_utils.type_bigint() }}) as lft,
    cast(rgt as {{ dbt_utils.type_bigint() }}) as rgt,
    cast(dashboard_layout_id as {{ dbt_utils.type_bigint() }}) as dashboard_layout_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('roles_ab1') }}
-- roles
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

