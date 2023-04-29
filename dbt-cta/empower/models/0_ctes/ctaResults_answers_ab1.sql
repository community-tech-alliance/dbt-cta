{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('ctaResults_base') }}
select
    _airbyte_ctaResults_hashid,
    {{ json_extract_scalar('answers', ['11'], ['11']) }} as _11,
    {{ json_extract_scalar('answers', ['1'], ['1']) }} as _1,
    {{ json_extract_scalar('answers', ['10'], ['10']) }} as _10,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('ctaResults_base') }} as table_alias
where 1 = 1
and answers is not null
