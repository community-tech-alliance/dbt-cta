{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('bills_base') }}
{{ unnest_cte(ref('bills_base'), 'bills', 'Line') }}
select
    _airbyte_bills_hashid,
    {{ json_extract_scalar(unnested_column_value('Line'), ['LineNum'], ['LineNum']) }} as LineNum,
    {{ json_extract('', unnested_column_value('Line'), ['ItemBasedExpenseLineDetail'], ['ItemBasedExpenseLineDetail']) }} as ItemBasedExpenseLineDetail,
    {{ json_extract_scalar(unnested_column_value('Line'), ['Description'], ['Description']) }} as Description,
    {{ json_extract('', unnested_column_value('Line'), ['AccountBasedExpenseLineDetail'], ['AccountBasedExpenseLineDetail']) }} as AccountBasedExpenseLineDetail,
    {{ json_extract_scalar(unnested_column_value('Line'), ['DetailType'], ['DetailType']) }} as DetailType,
    {{ json_extract_scalar(unnested_column_value('Line'), ['Amount'], ['Amount']) }} as Amount,
    {{ json_extract_scalar(unnested_column_value('Line'), ['Id'], ['Id']) }} as Id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('bills_base') }}
-- Line at bills/Line
{{ cross_join_unnest('bills', 'Line') }}
where
    1 = 1
    and Line is not null
