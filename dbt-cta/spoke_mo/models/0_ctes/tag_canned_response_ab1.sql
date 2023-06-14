{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_tag_canned_response') }}
select
    {{ json_extract_scalar('_airbyte_data', ['canned_response_id'], ['canned_response_id']) }} as canned_response_id,
    {{ json_extract_scalar('_airbyte_data', ['tag_id'], ['tag_id']) }} as tag_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_tag_canned_response') }} as table_alias
-- tag_canned_response
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

