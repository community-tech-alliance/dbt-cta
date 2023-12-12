{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_delayed_jobs') }}
select
    {{ json_extract_scalar('_airbyte_data', ['handler'], ['handler']) }} as handler,
    {{ json_extract_scalar('_airbyte_data', ['locked_by'], ['locked_by']) }} as locked_by,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['locked_at'], ['locked_at']) }} as locked_at,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['run_at'], ['run_at']) }} as run_at,
    {{ json_extract_scalar('_airbyte_data', ['failed_at'], ['failed_at']) }} as failed_at,
    {{ json_extract_scalar('_airbyte_data', ['last_error'], ['last_error']) }} as last_error,
    {{ json_extract_scalar('_airbyte_data', ['priority'], ['priority']) }} as priority,
    {{ json_extract_scalar('_airbyte_data', ['queue'], ['queue']) }} as queue,
    {{ json_extract_scalar('_airbyte_data', ['attempts'], ['attempts']) }} as attempts,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_delayed_jobs') }} as table_alias
-- delayed_jobs
where 1 = 1

