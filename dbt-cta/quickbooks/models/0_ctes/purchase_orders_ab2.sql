{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('purchase_orders_ab1') }}
select
    cast(CurrencyRef as {{ type_json() }}) as CurrencyRef,
    cast(ExchangeRate as {{ dbt_utils.type_float() }}) as ExchangeRate,
    cast(ClassRef as {{ type_json() }}) as ClassRef,
    cast(EmailStatus as {{ dbt_utils.type_string() }}) as EmailStatus,
    cast(POStatus as {{ dbt_utils.type_string() }}) as POStatus,
    cast(ShipAddr as {{ type_json() }}) as ShipAddr,
    cast(VendorAddr as {{ type_json() }}) as VendorAddr,
    cast(MetaData as {{ type_json() }}) as MetaData,
    cast(DocNumber as {{ dbt_utils.type_string() }}) as DocNumber,
    cast({{ empty_string_to_null('DueDate') }} as {{ type_date() }}) as DueDate,
    cast(PrivateNote as {{ dbt_utils.type_string() }}) as PrivateNote,
    LinkedTxn,
    cast({{ empty_string_to_null('TxnDate') }} as {{ type_date() }}) as TxnDate,
    cast(airbyte_cursor as {{ dbt_utils.type_string() }}) as airbyte_cursor,
    cast(DepartmentRef as {{ type_json() }}) as DepartmentRef,
    Line,
    cast(SyncToken as {{ dbt_utils.type_string() }}) as SyncToken,
    {{ cast_to_boolean('sparse') }} as sparse,
    cast(TotalAmt as {{ dbt_utils.type_float() }}) as TotalAmt,
    cast(domain as {{ dbt_utils.type_string() }}) as domain,
    cast(APAccountRef as {{ type_json() }}) as APAccountRef,
    CustomField,
    cast(ShipTo as {{ type_json() }}) as ShipTo,
    cast(SalesTermRef as {{ type_json() }}) as SalesTermRef,
    cast(Id as {{ dbt_utils.type_string() }}) as Id,
    cast(VendorRef as {{ type_json() }}) as VendorRef,
    cast(Memo as {{ dbt_utils.type_string() }}) as Memo,
    cast(TxnTaxDetail as {{ type_json() }}) as TxnTaxDetail,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('purchase_orders_ab1') }}
-- purchase_orders
where 1 = 1
