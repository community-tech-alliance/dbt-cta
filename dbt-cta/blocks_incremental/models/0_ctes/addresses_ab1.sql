{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_addresses') }}
select
    {{ json_extract_scalar('_airbyte_data', ['line_three'], ['line_three']) }} as line_three,
    {{ json_extract_scalar('_airbyte_data', ['city'], ['city']) }} as city,
    {{ json_extract_scalar('_airbyte_data', ['line_one'], ['line_one']) }} as line_one,
    {{ json_extract_scalar('_airbyte_data', ['county'], ['county']) }} as county,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['zipcode'], ['zipcode']) }} as zipcode,
    {{ json_extract_scalar('_airbyte_data', ['county_id'], ['county_id']) }} as county_id,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['line_four'], ['line_four']) }} as line_four,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('_airbyte_data', ['line_two'], ['line_two']) }} as line_two,
    {{ json_extract_scalar('_airbyte_data', ['tsv_full_address'], ['tsv_full_address']) }} as tsv_full_address,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_addresses') }}
-- addresses
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

