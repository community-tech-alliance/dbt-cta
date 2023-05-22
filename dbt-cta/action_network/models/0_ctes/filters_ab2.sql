{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('filters_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(uuid as {{ dbt_utils.type_string() }}) as uuid,
    cast(total as {{ dbt_utils.type_bigint() }}) as total,
    cast(params as {{ dbt_utils.type_string() }}) as params,
    cast(status as {{ dbt_utils.type_bigint() }}) as status,
    cast(results as {{ dbt_utils.type_string() }}) as results,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(backup_params as {{ dbt_utils.type_string() }}) as backup_params,
    cast(filterable_id as {{ dbt_utils.type_bigint() }}) as filterable_id,
    cast(filterable_type as {{ dbt_utils.type_string() }}) as filterable_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('filters_ab1') }}
-- filters
where 1 = 1

