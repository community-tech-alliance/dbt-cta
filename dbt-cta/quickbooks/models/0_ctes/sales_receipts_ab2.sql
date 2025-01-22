{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('sales_receipts_ab1') }}
select
    cast(CurrencyRef as {{ type_json() }}) as CurrencyRef,
    cast(ExchangeRate as {{ dbt_utils.type_float() }}) as ExchangeRate,
    cast(EmailStatus as {{ dbt_utils.type_string() }}) as EmailStatus,
    cast(ShipAddr as {{ type_json() }}) as ShipAddr,
    cast(HomeTotalAmt as {{ dbt_utils.type_float() }}) as HomeTotalAmt,
    cast(MetaData as {{ type_json() }}) as MetaData,
    cast(PaymentMethodRef as {{ type_json() }}) as PaymentMethodRef,
    cast(DocNumber as {{ dbt_utils.type_string() }}) as DocNumber,
    cast(PrintStatus as {{ dbt_utils.type_string() }}) as PrintStatus,
    cast(BillEmail as {{ type_json() }}) as BillEmail,
    LinkedTxn,
    cast(BillAddr as {{ type_json() }}) as BillAddr,
    cast(PaymentRefNum as {{ dbt_utils.type_string() }}) as PaymentRefNum,
    cast({{ empty_string_to_null('TxnDate') }} as {{ type_date() }}) as TxnDate,
    cast(airbyte_cursor as {{ dbt_utils.type_string() }}) as airbyte_cursor,
    cast(CustomerMemo as {{ type_json() }}) as CustomerMemo,
    Line,
    cast(SyncToken as {{ dbt_utils.type_string() }}) as SyncToken,
    cast(DepositToAccountRef as {{ type_json() }}) as DepositToAccountRef,
    {{ cast_to_boolean('sparse') }} as sparse,
    cast(TotalAmt as {{ dbt_utils.type_float() }}) as TotalAmt,
    cast(domain as {{ dbt_utils.type_string() }}) as domain,
    CustomField,
    cast(Id as {{ dbt_utils.type_string() }}) as Id,
    cast(CustomerRef as {{ type_json() }}) as CustomerRef,
    cast(Balance as {{ dbt_utils.type_bigint() }}) as Balance,
    {{ cast_to_boolean('ApplyTaxAfterDiscount') }} as ApplyTaxAfterDiscount,
    cast(TxnTaxDetail as {{ type_json() }}) as TxnTaxDetail,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('sales_receipts_ab1') }}
-- sales_receipts
where 1 = 1
