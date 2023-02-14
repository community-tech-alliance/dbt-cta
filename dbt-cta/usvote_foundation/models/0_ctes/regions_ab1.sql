{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_usvote_foundation",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('usvote_foundation', '_airbyte_raw_regions') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('_airbyte_data', ['county'], ['county']) }} as county,
    {{ json_extract_scalar('_airbyte_data', ['state_abbr'], ['state_abbr']) }} as state_abbr,
    {{ json_extract_scalar('_airbyte_data', ['state_name'], ['state_name']) }} as state_name,
    {{ json_extract_scalar('_airbyte_data', ['county_name'], ['county_name']) }} as county_name,
    {{ json_extract_scalar('_airbyte_data', ['region_name'], ['region_name']) }} as region_name,
    {{ json_extract_scalar('_airbyte_data', ['municipality'], ['municipality']) }} as municipality,
    {{ json_extract_scalar('_airbyte_data', ['resource_uri'], ['resource_uri']) }} as resource_uri,
    {{ json_extract_scalar('_airbyte_data', ['municipality_name'], ['municipality_name']) }} as municipality_name,
    {{ json_extract_scalar('_airbyte_data', ['municipality_type'], ['municipality_type']) }} as municipality_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_regions') }} as table_alias
-- regions
where 1 = 1

