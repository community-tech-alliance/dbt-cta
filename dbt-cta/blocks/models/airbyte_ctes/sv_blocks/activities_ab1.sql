{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('sv_blocks', '_airbyte_raw_activities') }}
select
    {{ json_extract_scalar('_airbyte_data', ['recipient_type'], ['recipient_type']) }} as recipient_type,
    {{ json_extract_scalar('_airbyte_data', ['trackable_id'], ['trackable_id']) }} as trackable_id,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['owner_id'], ['owner_id']) }} as owner_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['trackable_type'], ['trackable_type']) }} as trackable_type,
    {{ json_extract_scalar('_airbyte_data', ['parameters'], ['parameters']) }} as parameters,
    {{ json_extract_scalar('_airbyte_data', ['key'], ['key']) }} as key,
    {{ json_extract_scalar('_airbyte_data', ['owner_type'], ['owner_type']) }} as owner_type,
    {{ json_extract_scalar('_airbyte_data', ['recipient_id'], ['recipient_id']) }} as recipient_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('sv_blocks', '_airbyte_raw_activities') }} as table_alias
-- activities
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

