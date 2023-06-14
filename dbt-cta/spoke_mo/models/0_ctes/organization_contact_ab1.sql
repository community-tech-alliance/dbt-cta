{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_organization_contact') }}
select
    {{ json_extract_scalar('_airbyte_data', ['carrier'], ['carrier']) }} as carrier,
    {{ json_extract_scalar('_airbyte_data', ['last_lookup'], ['last_lookup']) }} as last_lookup,
    {{ json_extract_scalar('_airbyte_data', ['lookup_name'], ['lookup_name']) }} as lookup_name,
    {{ json_extract_scalar('_airbyte_data', ['status_code'], ['status_code']) }} as status_code,
    {{ json_extract_scalar('_airbyte_data', ['subscribe_status'], ['subscribe_status']) }} as subscribe_status,
    {{ json_extract_scalar('_airbyte_data', ['service'], ['service']) }} as service,
    {{ json_extract_scalar('_airbyte_data', ['organization_id'], ['organization_id']) }} as organization_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['contact_number'], ['contact_number']) }} as contact_number,
    {{ json_extract_scalar('_airbyte_data', ['user_number'], ['user_number']) }} as user_number,
    {{ json_extract_scalar('_airbyte_data', ['last_error_code'], ['last_error_code']) }} as last_error_code,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_organization_contact') }} as table_alias
-- organization_contact
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

