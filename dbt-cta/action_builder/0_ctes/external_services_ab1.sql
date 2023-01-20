{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_external_services') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['client_id'], ['client_id']) }} as client_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['expires_in'], ['expires_in']) }} as expires_in,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['workflow_id'], ['workflow_id']) }} as workflow_id,
    {{ json_extract_scalar('_airbyte_data', ['access_token'], ['access_token']) }} as access_token,
    {{ json_extract_scalar('_airbyte_data', ['service_name'], ['service_name']) }} as service_name,
    {{ json_extract_scalar('_airbyte_data', ['client_secret'], ['client_secret']) }} as client_secret,
    {{ json_extract_scalar('_airbyte_data', ['token_updated_at'], ['token_updated_at']) }} as token_updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_external_services') }} as table_alias
-- external_services
where 1 = 1

