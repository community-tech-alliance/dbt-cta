{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('sales_receipts_base') }}
{{ unnest_cte(ref('sales_receipts_base'), 'sales_receipts', 'LinkedTxn') }}
select
    _airbyte_sales_receipts_hashid,
    {{ json_extract_scalar(unnested_column_value('LinkedTxn'), ['TxnId'], ['TxnId']) }} as TxnId,
    {{ json_extract_scalar(unnested_column_value('LinkedTxn'), ['TxnType'], ['TxnType']) }} as TxnType,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('sales_receipts_base') }}
-- LinkedTxn at sales_receipts/LinkedTxn
{{ cross_join_unnest('sales_receipts', 'LinkedTxn') }}
where
    1 = 1
    and LinkedTxn is not null
