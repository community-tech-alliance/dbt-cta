{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('sales_receipts') }}
{{ unnest_cte(ref('sales_receipts'), 'sales_receipts', 'LinkedTxn') }}
select
    _airbyte_sales_receipts_hashid,
    {{ json_extract_scalar(unnested_column_value('LinkedTxn'), ['TxnId'], ['TxnId']) }} as TxnId,
    {{ json_extract_scalar(unnested_column_value('LinkedTxn'), ['TxnType'], ['TxnType']) }} as TxnType,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('sales_receipts') }} as table_alias
-- LinkedTxn at sales_receipts/LinkedTxn
{{ cross_join_unnest('sales_receipts', 'LinkedTxn') }}
where 1 = 1
and LinkedTxn is not null

