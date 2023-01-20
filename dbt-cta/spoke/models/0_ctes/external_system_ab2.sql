{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('external_system_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(username as {{ dbt_utils.type_string() }}) as username,
    cast({{ empty_string_to_null('synced_at') }} as {{ type_timestamp_with_timezone() }}) as synced_at,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_with_timezone() }}) as updated_at,
    cast(api_key_ref as {{ dbt_utils.type_string() }}) as api_key_ref,
    cast(organization_id as {{ dbt_utils.type_bigint() }}) as organization_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('external_system_ab1') }}
-- external_system
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

