{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_dashboard_widgets') }}
select
    {{ json_extract_scalar('_airbyte_data', ['widget_id'], ['widget_id']) }} as widget_id,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_string_array('_airbyte_data', ['measurable_ids'], ['measurable_ids']) }} as measurable_ids,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['position'], ['position']) }} as position,
    {{ json_extract_scalar('_airbyte_data', ['title'], ['title']) }} as title,
    {{ json_extract_scalar('_airbyte_data', ['measurable_type'], ['measurable_type']) }} as measurable_type,
    {{ json_extract_scalar('_airbyte_data', ['dashboard_layout_id'], ['dashboard_layout_id']) }} as dashboard_layout_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_dashboard_widgets') }}
-- dashboard_widgets
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

