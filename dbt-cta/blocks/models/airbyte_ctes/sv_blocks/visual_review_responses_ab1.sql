{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('sv_blocks', '_airbyte_raw_visual_review_responses') }}
select
    {{ json_extract_scalar('_airbyte_data', ['shift_type'], ['shift_type']) }} as shift_type,
    {{ json_extract_scalar('_airbyte_data', ['implies_not_form'], ['implies_not_form']) }} as implies_not_form,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['response'], ['response']) }} as response,
    {{ json_extract_scalar('_airbyte_data', ['active'], ['active']) }} as active,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['grouping_metadata'], ['grouping_metadata']) }} as grouping_metadata,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['implies_incomplete_form'], ['implies_incomplete_form']) }} as implies_incomplete_form,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('sv_blocks', '_airbyte_raw_visual_review_responses') }} as table_alias
-- visual_review_responses
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

