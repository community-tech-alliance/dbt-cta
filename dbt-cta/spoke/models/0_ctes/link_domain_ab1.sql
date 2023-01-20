{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_link_domain') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['domain'], ['domain']) }} as domain,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['cycled_out_at'], ['cycled_out_at']) }} as cycled_out_at,
    {{ json_extract_scalar('_airbyte_data', ['max_usage_count'], ['max_usage_count']) }} as max_usage_count,
    {{ json_extract_scalar('_airbyte_data', ['organization_id'], ['organization_id']) }} as organization_id,
    {{ json_extract_scalar('_airbyte_data', ['current_usage_count'], ['current_usage_count']) }} as current_usage_count,
    {{ json_extract_scalar('_airbyte_data', ['is_manually_disabled'], ['is_manually_disabled']) }} as is_manually_disabled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_link_domain') }} as table_alias
-- link_domain
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

