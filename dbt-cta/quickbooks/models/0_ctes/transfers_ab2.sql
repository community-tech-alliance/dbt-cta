{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('transfers_ab1') }}
select
    cast(SyncToken as {{ dbt_utils.type_string() }}) as SyncToken,
    cast(CurrencyRef as {{ type_json() }}) as CurrencyRef,
    cast(ExchangeRate as {{ dbt_utils.type_float() }}) as ExchangeRate,
    cast(ToAccountRef as {{ type_json() }}) as ToAccountRef,
    cast(FromAccountRef as {{ type_json() }}) as FromAccountRef,
    cast(MetaData as {{ type_json() }}) as MetaData,
    cast(Amount as {{ dbt_utils.type_float() }}) as Amount,
    cast(domain as {{ dbt_utils.type_string() }}) as domain,
    cast({{ empty_string_to_null('TxnDate') }} as {{ type_date() }}) as TxnDate,
    cast(airbyte_cursor as {{ dbt_utils.type_string() }}) as airbyte_cursor,
    cast(Id as {{ dbt_utils.type_string() }}) as Id,
    cast(PrivateNote as {{ dbt_utils.type_string() }}) as PrivateNote,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('transfers_ab1') }}
-- transfers
where 1 = 1
