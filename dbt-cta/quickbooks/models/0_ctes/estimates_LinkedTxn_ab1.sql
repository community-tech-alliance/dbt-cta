{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('estimates_base') }}
{{ unnest_cte(ref('estimates_base'), 'estimates', 'LinkedTxn') }}
select
    _airbyte_estimates_hashid,
    {{ json_extract_scalar(unnested_column_value('LinkedTxn'), ['TxnId'], ['TxnId']) }} as TxnId,
    {{ json_extract_scalar(unnested_column_value('LinkedTxn'), ['TxnType'], ['TxnType']) }} as TxnType,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('estimates_base') }}
-- LinkedTxn at estimates/LinkedTxn
{{ cross_join_unnest('estimates', 'LinkedTxn') }}
where
    1 = 1
    and LinkedTxn is not null
