{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('purchase_orders_Line_ItemBasedExpenseLineDetail_ab1') }}
select
    _airbyte_Line_hashid,
    cast(UnitPrice as {{ dbt_utils.type_float() }}) as UnitPrice,
    cast(ClassRef as {{ type_json() }}) as ClassRef,
    cast(TaxCodeRef as {{ type_json() }}) as TaxCodeRef,
    cast(BillableStatus as {{ dbt_utils.type_string() }}) as BillableStatus,
    cast(Qty as {{ dbt_utils.type_bigint() }}) as Qty,
    cast(ItemRef as {{ type_json() }}) as ItemRef,
    cast(CustomerRef as {{ type_json() }}) as CustomerRef,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('purchase_orders_Line_ItemBasedExpenseLineDetail_ab1') }}
-- ItemBasedExpenseLineDetail at purchase_orders/Line/ItemBasedExpenseLineDetail
where 1 = 1

