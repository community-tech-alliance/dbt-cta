{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_default",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('page') }}
select
    _airbyte_page_hashid,
    {{ json_extract_scalar('cover', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('cover', ['source'], ['source']) }} as source,
    {{ json_extract_scalar('cover', ['cover_id'], ['cover_id']) }} as cover_id,
    {{ json_extract_scalar('cover', ['offset_x'], ['offset_x']) }} as offset_x,
    {{ json_extract_scalar('cover', ['offset_y'], ['offset_y']) }} as offset_y,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page') }} as table_alias
-- cover at page/cover
where 1 = 1
and cover is not null

