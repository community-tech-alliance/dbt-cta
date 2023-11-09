{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('bill_payments_base') }}
{{ unnest_cte(ref('bill_payments_base'), 'bill_payments', 'Line_base') }}
select
    _airbyte_bill_payments_hashid,
    {{ json_extract_scalar(unnested_column_value('Line'), ['Amount'], ['Amount']) }} as Amount,
    {{ json_extract_array(unnested_column_value('Line'), ['LinkedTxn'], ['LinkedTxn']) }} as LinkedTxn,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('bill_payments_base') }} as table_alias
-- Line at bill_payments/Line
{{ cross_join_unnest('bill_payments', 'Line_base') }}
where 1 = 1
and Line is not null

