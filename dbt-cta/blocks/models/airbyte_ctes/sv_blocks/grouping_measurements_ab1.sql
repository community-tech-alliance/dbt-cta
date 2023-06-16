{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('sv_blocks', '_airbyte_raw_grouping_measurements') }}
select
    {{ json_extract_scalar('_airbyte_data', ['measurable_id'], ['measurable_id']) }} as measurable_id,
    {{ json_extract_scalar('_airbyte_data', ['grouping_id'], ['grouping_id']) }} as grouping_id,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['position'], ['position']) }} as position,
    {{ json_extract_scalar('_airbyte_data', ['measurable_type'], ['measurable_type']) }} as measurable_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('sv_blocks', '_airbyte_raw_grouping_measurements') }} as table_alias
-- grouping_measurements
where 1 = 1

