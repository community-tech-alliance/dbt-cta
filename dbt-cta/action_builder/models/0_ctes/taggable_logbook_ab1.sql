{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_taggable_logbook') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['notes'], ['notes']) }} as notes,
    {{ json_extract_scalar('_airbyte_data', ['tag_id'], ['tag_id']) }} as tag_id,
    {{ json_extract_scalar('_airbyte_data', ['available'], ['available']) }} as available,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['created_by'], ['created_by']) }} as created_by,
    {{ json_extract_scalar('_airbyte_data', ['deleted_at'], ['deleted_at']) }} as deleted_at,
    {{ json_extract_scalar('_airbyte_data', ['deleted_by'], ['deleted_by']) }} as deleted_by,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['campaign_id'], ['campaign_id']) }} as campaign_id,
    {{ json_extract_scalar('_airbyte_data', ['interact_id'], ['interact_id']) }} as interact_id,
    {{ json_extract_scalar('_airbyte_data', ['taggable_id'], ['taggable_id']) }} as taggable_id,
    {{ json_extract_scalar('_airbyte_data', ['signature_id'], ['signature_id']) }} as signature_id,
    {{ json_extract_scalar('_airbyte_data', ['taggable_type'], ['taggable_type']) }} as taggable_type,
    {{ json_extract_scalar('_airbyte_data', ['updated_by_id'], ['updated_by_id']) }} as updated_by_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_taggable_logbook') }} as table_alias
-- taggable_logbook
where 1 = 1

