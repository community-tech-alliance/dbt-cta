{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('purchases_PurchaseEx_any_value_ab1') }}
select
    _airbyte_any_hashid,
    cast(Value as {{ dbt_utils.type_string() }}) as Value,
    cast(Name as {{ dbt_utils.type_string() }}) as Name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('purchases_PurchaseEx_any_value_ab1') }}
-- value at purchases/PurchaseEx/any/value
where 1 = 1

