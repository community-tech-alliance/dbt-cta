{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_segments') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_array('_airbyte_data', ['visible_to'], ['visible_to']) }} as visible_to,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['source_type'], ['source_type']) }} as source_type,
    {{ json_extract_scalar('_airbyte_data', ['ad_account_id'], ['ad_account_id']) }} as ad_account_id,
    {{ json_extract_scalar('_airbyte_data', ['upload_status'], ['upload_status']) }} as upload_status,
    {{ json_extract_scalar('_airbyte_data', ['organization_id'], ['organization_id']) }} as organization_id,
    {{ json_extract_scalar('_airbyte_data', ['retention_in_days'], ['retention_in_days']) }} as retention_in_days,
    {{ json_extract_scalar('_airbyte_data', ['targetable_status'], ['targetable_status']) }} as targetable_status,
    {{ json_extract_scalar('_airbyte_data', ['approximate_number_users'], ['approximate_number_users']) }} as approximate_number_users,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_segments') }} as table_alias
-- segments
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

