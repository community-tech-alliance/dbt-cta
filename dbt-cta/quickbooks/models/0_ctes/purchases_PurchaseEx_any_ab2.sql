{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('purchases_PurchaseEx_any_ab1') }}
select
    _airbyte_PurchaseEx_hashid,
    {{ cast_to_boolean('nil') }} as nil,
    {{ cast_to_boolean('typeSubstituted') }} as typeSubstituted,
    {{ cast_to_boolean('globalScope') }} as globalScope,
    cast(scope as {{ dbt_utils.type_string() }}) as scope,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(declaredType as {{ dbt_utils.type_string() }}) as declaredType,
    cast(value as {{ type_json() }}) as value,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('purchases_PurchaseEx_any_ab1') }}
-- any at purchases/PurchaseEx/any
where 1 = 1
