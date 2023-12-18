{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_widgets') }}
select
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['number_of_measurables'], ['number_of_measurables']) }} as number_of_measurables,
    {{ json_extract_scalar('_airbyte_data', ['column_span'], ['column_span']) }} as column_span,
    {{ json_extract_scalar('_airbyte_data', ['block_id'], ['block_id']) }} as block_id,
    {{ json_extract_scalar('_airbyte_data', ['widget_type'], ['widget_type']) }} as widget_type,
    {{ json_extract_scalar('_airbyte_data', ['measurable_type'], ['measurable_type']) }} as measurable_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_widgets') }} as table_alias
-- widgets

