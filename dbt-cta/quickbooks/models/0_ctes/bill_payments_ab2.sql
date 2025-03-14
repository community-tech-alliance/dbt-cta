{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('bill_payments_ab1') }}
select
    cast(CurrencyRef as {{ type_json() }}) as CurrencyRef,
    cast(ExchangeRate as {{ dbt_utils.type_float() }}) as ExchangeRate,
    cast({{ empty_string_to_null('TxnDate') }} as {{ type_date() }}) as TxnDate,
    cast(airbyte_cursor as {{ dbt_utils.type_string() }}) as airbyte_cursor,
    cast(PayType as {{ dbt_utils.type_string() }}) as PayType,
    cast(DepartmentRef as {{ type_json() }}) as DepartmentRef,
    Line,
    cast(SyncToken as {{ dbt_utils.type_string() }}) as SyncToken,
    cast(CreditCardPayment as {{ type_json() }}) as CreditCardPayment,
    {{ cast_to_boolean('sparse') }} as sparse,
    cast(TotalAmt as {{ dbt_utils.type_float() }}) as TotalAmt,
    cast(MetaData as {{ type_json() }}) as MetaData,
    cast(domain as {{ dbt_utils.type_string() }}) as domain,
    cast(DocNumber as {{ dbt_utils.type_string() }}) as DocNumber,
    cast(APAccountRef as {{ type_json() }}) as APAccountRef,
    cast(CheckPayment as {{ type_json() }}) as CheckPayment,
    cast(Id as {{ dbt_utils.type_string() }}) as Id,
    cast(VendorRef as {{ type_json() }}) as VendorRef,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('bill_payments_ab1') }}
-- bill_payments
where 1 = 1
