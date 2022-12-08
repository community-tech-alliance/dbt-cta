{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('shifts') }}
{{ unnest_cte(ref('shifts'), 'shifts', 'breaks') }}
select
    _airbyte_shifts_hashid,
    {{ json_extract_scalar(unnested_column_value('breaks'), ['id'], ['id']) }} as id,
    {{ json_extract_scalar(unnested_column_value('breaks'), ['name'], ['name']) }} as name,
    {{ json_extract_scalar(unnested_column_value('breaks'), ['end_at'], ['end_at']) }} as end_at,
    {{ json_extract_scalar(unnested_column_value('breaks'), ['is_paid'], ['is_paid']) }} as is_paid,
    {{ json_extract_scalar(unnested_column_value('breaks'), ['start_at'], ['start_at']) }} as start_at,
    {{ json_extract_scalar(unnested_column_value('breaks'), ['break_type_id'], ['break_type_id']) }} as break_type_id,
    {{ json_extract_scalar(unnested_column_value('breaks'), ['expected_duration'], ['expected_duration']) }} as expected_duration,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('shifts_base') }} as table_alias
-- breaks at shifts/breaks
{{ cross_join_unnest('shifts', 'breaks') }}
where 1 = 1
and breaks is not null

