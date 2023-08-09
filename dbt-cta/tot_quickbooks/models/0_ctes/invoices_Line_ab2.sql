{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('invoices_Line_ab1') }}
select
    _airbyte_invoices_hashid,
    cast(LineNum as {{ dbt_utils.type_bigint() }}) as LineNum,
    cast(DiscountLineDetail as {{ type_json() }}) as DiscountLineDetail,
    cast(Description as {{ dbt_utils.type_string() }}) as Description,
    cast(DetailType as {{ dbt_utils.type_string() }}) as DetailType,
    cast(Amount as {{ dbt_utils.type_float() }}) as Amount,
    cast(SalesItemLineDetail as {{ type_json() }}) as SalesItemLineDetail,
    cast(Id as {{ dbt_utils.type_string() }}) as Id,
    LinkedTxn,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('invoices_Line_ab1') }}
-- Line at invoices/Line
where 1 = 1

