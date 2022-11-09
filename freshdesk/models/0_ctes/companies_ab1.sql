{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_companies') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['note'], ['note']) }} as note,
    {{ json_extract_string_array('_airbyte_data', ['domains'], ['domains']) }} as domains,
    {{ json_extract_scalar('_airbyte_data', ['industry'], ['industry']) }} as industry,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['account_tier'], ['account_tier']) }} as account_tier,
    {{ json_extract_scalar('_airbyte_data', ['health_score'], ['health_score']) }} as health_score,
    {{ json_extract_scalar('_airbyte_data', ['renewal_date'], ['renewal_date']) }} as renewal_date,
    {{ json_extract('table_alias', '_airbyte_data', ['custom_fields'], ['custom_fields']) }} as custom_fields,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_companies') }} as table_alias
-- companies
where 1 = 1

