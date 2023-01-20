{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('external_list_ab1') }}
select
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(system_id as {{ dbt_utils.type_string() }}) as system_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(door_count as {{ dbt_utils.type_bigint() }}) as door_count,
    cast(list_count as {{ dbt_utils.type_bigint() }}) as list_count,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_with_timezone() }}) as updated_at,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(external_id as {{ dbt_utils.type_bigint() }}) as external_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('external_list_ab1') }}
-- external_list
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

