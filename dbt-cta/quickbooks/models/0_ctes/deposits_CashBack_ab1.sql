{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('deposits_base') }}
select
    _airbyte_deposits_hashid,
    {{ json_extract_scalar('CashBack', ['Amount'], ['Amount']) }} as Amount,
    {{ json_extract('table_alias', 'CashBack', ['AccountRef'], ['AccountRef']) }} as AccountRef,
    {{ json_extract_scalar('CashBack', ['Memo'], ['Memo']) }} as Memo,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('deposits_base') }} as table_alias
-- CashBack at deposits/CashBack
where 1 = 1
and CashBack is not null

