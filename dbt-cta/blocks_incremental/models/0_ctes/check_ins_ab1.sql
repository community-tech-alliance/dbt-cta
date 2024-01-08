{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_check_ins') }}
select
    {{ json_extract_scalar('_airbyte_data', ['end_date'], ['end_date']) }} as end_date,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['turf_id'], ['turf_id']) }} as turf_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_string_array('_airbyte_data', ['days_of_the_week'], ['days_of_the_week']) }} as days_of_the_week,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_check_ins') }}
-- check_ins
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

