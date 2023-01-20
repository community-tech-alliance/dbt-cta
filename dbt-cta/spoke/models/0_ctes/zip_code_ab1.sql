{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_zip_code') }}
select
    {{ json_extract_scalar('_airbyte_data', ['zip'], ['zip']) }} as zip,
    {{ json_extract_scalar('_airbyte_data', ['city'], ['city']) }} as city,
    {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('_airbyte_data', ['has_dst'], ['has_dst']) }} as has_dst,
    {{ json_extract_scalar('_airbyte_data', ['latitude'], ['latitude']) }} as latitude,
    {{ json_extract_scalar('_airbyte_data', ['longitude'], ['longitude']) }} as longitude,
    {{ json_extract_scalar('_airbyte_data', ['timezone_offset'], ['timezone_offset']) }} as timezone_offset,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_zip_code') }} as table_alias
-- zip_code
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

