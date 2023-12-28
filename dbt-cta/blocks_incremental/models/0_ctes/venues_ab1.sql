{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_venues') }}
select
    {{ json_extract_scalar('_airbyte_data', ['maximum_size'], ['maximum_size']) }} as maximum_size,
    {{ json_extract_scalar('_airbyte_data', ['rooms_available'], ['rooms_available']) }} as rooms_available,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['address_id'], ['address_id']) }} as address_id,
    {{ json_extract_scalar('_airbyte_data', ['it_support'], ['it_support']) }} as it_support,
    {{ json_extract_scalar('_airbyte_data', ['largest_size'], ['largest_size']) }} as largest_size,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['public_transportation'], ['public_transportation']) }} as public_transportation,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['parking_spots'], ['parking_spots']) }} as parking_spots,
    {{ json_extract_scalar('_airbyte_data', ['hosted_event'], ['hosted_event']) }} as hosted_event,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_venues') }}
-- venues
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

