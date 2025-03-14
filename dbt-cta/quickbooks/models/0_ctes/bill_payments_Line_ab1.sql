{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('bill_payments_base') }}
{{ unnest_cte(ref('bill_payments_base'), 'bill_payments', 'Line') }}
select
    _airbyte_bill_payments_hashid,
    {{ json_extract_scalar(unnested_column_value('Line'), ['Amount'], ['Amount']) }} as Amount,
    {{ json_extract_array(unnested_column_value('Line'), ['LinkedTxn'], ['LinkedTxn']) }} as LinkedTxn,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('bill_payments_base') }}
-- Line at bill_payments/Line
{{ cross_join_unnest('bill_payments', 'Line') }}
where
    1 = 1
    and Line is not null
