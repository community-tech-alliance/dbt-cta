{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('sv_blocks', '_airbyte_raw_collections_roles') }}
select
    {{ json_extract_scalar('_airbyte_data', ['collection_id'], ['collection_id']) }} as collection_id,
    {{ json_extract_scalar('_airbyte_data', ['role_id'], ['role_id']) }} as role_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('sv_blocks', '_airbyte_raw_collections_roles') }} as table_alias
-- collections_roles
where 1 = 1

