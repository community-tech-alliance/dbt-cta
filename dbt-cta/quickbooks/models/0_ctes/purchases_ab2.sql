{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('purchases_ab1') }}
select
    cast(CurrencyRef as {{ type_json() }}) as CurrencyRef,
    cast(ExchangeRate as {{ dbt_utils.type_float() }}) as ExchangeRate,
    cast({{ empty_string_to_null('TxnDate') }} as {{ type_date() }}) as TxnDate,
    cast(airbyte_cursor as {{ dbt_utils.type_string() }}) as airbyte_cursor,
    cast(AccountRef as {{ type_json() }}) as AccountRef,
    cast(RemitToAddr as {{ type_json() }}) as RemitToAddr,
    Line,
    cast(SyncToken as {{ dbt_utils.type_string() }}) as SyncToken,
    {{ cast_to_boolean('Credit') }} as Credit,
    {{ cast_to_boolean('sparse') }} as sparse,
    cast(TotalAmt as {{ dbt_utils.type_float() }}) as TotalAmt,
    cast(MetaData as {{ type_json() }}) as MetaData,
    cast(domain as {{ dbt_utils.type_string() }}) as domain,
    cast(DocNumber as {{ dbt_utils.type_string() }}) as DocNumber,
    cast(PurchaseEx as {{ type_json() }}) as PurchaseEx,
    cast(PaymentType as {{ dbt_utils.type_string() }}) as PaymentType,
    cast(Id as {{ dbt_utils.type_string() }}) as Id,
    cast(PrintStatus as {{ dbt_utils.type_string() }}) as PrintStatus,
    cast(EntityRef as {{ type_json() }}) as EntityRef,
    cast(PrivateNote as {{ dbt_utils.type_string() }}) as PrivateNote,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('purchases_ab1') }}
-- purchases
where 1 = 1

