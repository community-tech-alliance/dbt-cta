{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_organization') }}
select
    {{ json_extract_scalar('_airbyte_data', ['features'], ['features']) }} as features,
    {{ json_extract_scalar('_airbyte_data', ['texting_hours_start'], ['texting_hours_start']) }} as texting_hours_start,
    {{ json_extract_scalar('_airbyte_data', ['texting_hours_enforced'], ['texting_hours_enforced']) }} as texting_hours_enforced,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['texting_hours_end'], ['texting_hours_end']) }} as texting_hours_end,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['uuid'], ['uuid']) }} as uuid,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_organization') }} as table_alias
-- organization
where 1 = 1


