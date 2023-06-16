{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('sv_blocks', '_airbyte_raw_quick_links') }}
select
    {{ json_extract_scalar('_airbyte_data', ['bg_color'], ['bg_color']) }} as bg_color,
    {{ json_extract_scalar('_airbyte_data', ['size'], ['size']) }} as size,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['icon'], ['icon']) }} as icon,
    {{ json_extract_scalar('_airbyte_data', ['link'], ['link']) }} as link,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['label'], ['label']) }} as label,
    {{ json_extract_scalar('_airbyte_data', ['text_color'], ['text_color']) }} as text_color,
    {{ json_extract_scalar('_airbyte_data', ['block_id'], ['block_id']) }} as block_id,
    {{ json_extract_scalar('_airbyte_data', ['target'], ['target']) }} as target,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('sv_blocks', '_airbyte_raw_quick_links') }} as table_alias
-- quick_links
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

