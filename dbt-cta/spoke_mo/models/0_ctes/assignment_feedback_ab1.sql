{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_assignment_feedback') }}
select
    {{ json_extract_scalar('_airbyte_data', ['feedback'], ['feedback']) }} as feedback,
    {{ json_extract_scalar('_airbyte_data', ['assignment_id'], ['assignment_id']) }} as assignment_id,
    {{ json_extract_scalar('_airbyte_data', ['is_acknowledged'], ['is_acknowledged']) }} as is_acknowledged,
    {{ json_extract_scalar('_airbyte_data', ['creator_id'], ['creator_id']) }} as creator_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['complete'], ['complete']) }} as complete,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_assignment_feedback') }} as table_alias
-- assignment_feedback
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

