{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_activities') }}
select
    {{ json_extract_scalar('_airbyte_data', ['date'], ['date']) }} as date,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['action'], ['action']) }} as action,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['time'], ['time']) }} as time,
    {{ json_extract_scalar('_airbyte_data', ['team_id'], ['team_id']) }} as team_id,
    {{ json_extract_scalar('_airbyte_data', ['category'], ['category']) }} as category,
    {{ json_extract_scalar('_airbyte_data', ['object_id'], ['object_id']) }} as object_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_activities') }} as table_alias
-- activities
where 1 = 1

