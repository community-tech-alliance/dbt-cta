{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('public', '_airbyte_raw_troll_trigger') }}
select
    {{ json_extract_scalar('_airbyte_data', ['mode'], ['mode']) }} as mode,
    {{ json_extract_scalar('_airbyte_data', ['token'], ['token']) }} as token,
    {{ json_extract_scalar('_airbyte_data', ['organization_id'], ['organization_id']) }} as organization_id,
    {{ json_extract_scalar('_airbyte_data', ['compiled_tsquery'], ['compiled_tsquery']) }} as compiled_tsquery,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('public', '_airbyte_raw_troll_trigger') }} as table_alias
-- troll_trigger
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

