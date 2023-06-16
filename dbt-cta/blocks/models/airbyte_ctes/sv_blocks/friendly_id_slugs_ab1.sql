{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('sv_blocks', '_airbyte_raw_friendly_id_slugs') }}
select
    {{ json_extract_scalar('_airbyte_data', ['sluggable_type'], ['sluggable_type']) }} as sluggable_type,
    {{ json_extract_scalar('_airbyte_data', ['scope'], ['scope']) }} as scope,
    {{ json_extract_scalar('_airbyte_data', ['sluggable_id'], ['sluggable_id']) }} as sluggable_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['slug'], ['slug']) }} as slug,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('sv_blocks', '_airbyte_raw_friendly_id_slugs') }} as table_alias
-- friendly_id_slugs
where 1 = 1

