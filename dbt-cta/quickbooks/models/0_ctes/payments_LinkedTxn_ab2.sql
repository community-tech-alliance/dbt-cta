{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payments_LinkedTxn_ab1') }}
select
    _airbyte_payments_hashid,
    cast(TxnId as {{ dbt_utils.type_string() }}) as TxnId,
    cast(TxnType as {{ dbt_utils.type_string() }}) as TxnType,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payments_LinkedTxn_ab1') }}
-- LinkedTxn at payments/LinkedTxn
where 1 = 1
