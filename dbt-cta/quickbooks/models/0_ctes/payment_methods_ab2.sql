{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payment_methods_ab1') }}
select
    cast(SyncToken as {{ dbt_utils.type_string() }}) as SyncToken,
    cast(Type as {{ dbt_utils.type_string() }}) as Type,
    {{ cast_to_boolean('Active') }} as Active,
    {{ cast_to_boolean('sparse') }} as sparse,
    cast(MetaData as {{ type_json() }}) as MetaData,
    cast(domain as {{ dbt_utils.type_string() }}) as domain,
    cast(airbyte_cursor as {{ dbt_utils.type_string() }}) as airbyte_cursor,
    cast(Id as {{ dbt_utils.type_string() }}) as Id,
    cast(Name as {{ dbt_utils.type_string() }}) as Name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_methods_ab1') }}
-- payment_methods
where 1 = 1

