{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('tickets_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(price as {{ dbt_utils.type_float() }}) as price,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(total as {{ dbt_utils.type_bigint() }}) as total,
    cast(hidden as {{ dbt_utils.type_bigint() }}) as hidden,
    cast(available as {{ dbt_utils.type_bigint() }}) as available,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(ticketed_event_id as {{ dbt_utils.type_bigint() }}) as ticketed_event_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('tickets_ab1') }}
-- tickets
where 1 = 1
