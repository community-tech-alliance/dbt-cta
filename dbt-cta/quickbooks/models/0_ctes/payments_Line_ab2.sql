{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payments_Line_ab1') }}
select
    _airbyte_payments_hashid,
    cast(Amount as {{ dbt_utils.type_float() }}) as Amount,
    cast(LineEx as {{ type_json() }}) as LineEx,
    LinkedTxn,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payments_Line_ab1') }}
-- Line at payments/Line
where 1 = 1
