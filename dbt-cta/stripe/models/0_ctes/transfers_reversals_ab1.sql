{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('transfers_base') }}
select
    _airbyte_transfers_hashid,
    {{ json_extract_scalar('reversals', ['url'], ['url']) }} as url,
    {{ json_extract_array('reversals', ['data'], ['data']) }} as data,
    {{ json_extract_scalar('reversals', ['object'], ['object']) }} as object,
    {{ json_extract_scalar('reversals', ['has_more'], ['has_more']) }} as has_more,
    {{ json_extract_scalar('reversals', ['total_count'], ['total_count']) }} as total_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('transfers_base') }} as table_alias
-- reversals at transfers/reversals
where 1 = 1
and reversals is not null
{{ incremental_clause('_airbyte_emitted_at') }}

