{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payments_ab1') }}
select
    cast(CurrencyRef as {{ type_json() }}) as CurrencyRef,
    cast(ExchangeRate as {{ dbt_utils.type_float() }}) as ExchangeRate,
    {{ cast_to_boolean('ProcessPayment') }} as ProcessPayment,
    cast(PaymentRefNum as {{ dbt_utils.type_string() }}) as PaymentRefNum,
    cast({{ empty_string_to_null('TxnDate') }} as {{ type_date() }}) as TxnDate,
    cast(airbyte_cursor as {{ dbt_utils.type_string() }}) as airbyte_cursor,
    Line,
    cast(UnappliedAmt as {{ dbt_utils.type_float() }}) as UnappliedAmt,
    cast(SyncToken as {{ dbt_utils.type_string() }}) as SyncToken,
    cast(DepositToAccountRef as {{ type_json() }}) as DepositToAccountRef,
    {{ cast_to_boolean('sparse') }} as sparse,
    cast(TotalAmt as {{ dbt_utils.type_float() }}) as TotalAmt,
    cast(MetaData as {{ type_json() }}) as MetaData,
    cast(PaymentMethodRef as {{ type_json() }}) as PaymentMethodRef,
    cast(domain as {{ dbt_utils.type_string() }}) as domain,
    cast(Id as {{ dbt_utils.type_string() }}) as Id,
    cast(ARAccountRef as {{ type_json() }}) as ARAccountRef,
    cast(CustomerRef as {{ type_json() }}) as CustomerRef,
    cast(PrivateNote as {{ dbt_utils.type_string() }}) as PrivateNote,
    LinkedTxn,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payments_ab1') }}
-- payments
where 1 = 1
