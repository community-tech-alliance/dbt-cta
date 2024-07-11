{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_job_request') }}
select
    {{ json_extract_scalar('_airbyte_data', ['job_type'], ['job_type']) }} as job_type,
    {{ json_extract_scalar('_airbyte_data', ['queue_name'], ['queue_name']) }} as queue_name,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['result_message'], ['result_message']) }} as result_message,
    {{ json_extract_scalar('_airbyte_data', ['payload'], ['payload']) }} as payload,
    {{ json_extract_scalar('_airbyte_data', ['organization_id'], ['organization_id']) }} as organization_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['assigned'], ['assigned']) }} as assigned,
    {{ json_extract_scalar('_airbyte_data', ['locks_queue'], ['locks_queue']) }} as locks_queue,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['campaign_id'], ['campaign_id']) }} as campaign_id,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_job_request') }} as table_alias
-- job_request
where 1 = 1


