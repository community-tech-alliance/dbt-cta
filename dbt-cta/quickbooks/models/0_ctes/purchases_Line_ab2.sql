{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('purchases_Line_ab1') }}
select
    _airbyte_purchases_hashid,
    cast(ItemBasedExpenseLineDetail as {{ type_json() }}) as ItemBasedExpenseLineDetail,
    cast(Description as {{ dbt_utils.type_string() }}) as Description,
    cast(AccountBasedExpenseLineDetail as {{ type_json() }}) as AccountBasedExpenseLineDetail,
    cast(DetailType as {{ dbt_utils.type_string() }}) as DetailType,
    cast(Amount as {{ dbt_utils.type_float() }}) as Amount,
    cast(Id as {{ dbt_utils.type_string() }}) as Id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('purchases_Line_ab1') }}
-- Line at purchases/Line
where 1 = 1
