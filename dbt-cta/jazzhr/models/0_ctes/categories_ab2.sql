{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('categories_ab1') }}
select
    cast(date_created as {{ dbt_utils.type_string() }}) as date_created,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(created_by as {{ dbt_utils.type_string() }}) as created_by,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('categories_ab1') }}
-- categories
where 1 = 1

