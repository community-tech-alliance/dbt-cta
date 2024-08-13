{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('refunds') }}
{{ unnest_cte(ref('refunds'), 'refunds', 'processing_fee') }}
select
    _airbyte_refunds_hashid,
    {{ json_extract_scalar(unnested_column_value('processing_fee'), ['type'], ['type']) }} as type,
    {{ json_extract('', unnested_column_value('processing_fee'), ['amount_money'], ['amount_money']) }} as amount_money,
    {{ json_extract_scalar(unnested_column_value('processing_fee'), ['effective_at'], ['effective_at']) }} as effective_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('refunds_base') }}
-- processing_fee at refunds/processing_fee
{{ cross_join_unnest('refunds', 'processing_fee') }}
where
    1 = 1
    and processing_fee is not null
{{ incremental_clause('_airbyte_emitted_at') }}

