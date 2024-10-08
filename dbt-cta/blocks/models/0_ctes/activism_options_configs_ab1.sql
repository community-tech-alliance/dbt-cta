{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_activism_options_configs') }}
select
    {{ json_extract_string_array('_airbyte_data', ['skills'], ['skills']) }} as skills,
    {{ json_extract_string_array('_airbyte_data', ['campaigns'], ['campaigns']) }} as campaigns,
    {{ json_extract_string_array('_airbyte_data', ['languages'], ['languages']) }} as languages,
    {{ json_extract_scalar('_airbyte_data', ['turf_id'], ['turf_id']) }} as turf_id,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_string_array('_airbyte_data', ['issues'], ['issues']) }} as issues,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_activism_options_configs') }}
-- activism_options_configs
where 1 = 1
