{% set raw_table = env_var("CTA_DATASET_ID", "not-set") ~ "_raw__stream_filters" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['uuid'], ['uuid']) }} as uuid,
    {{ json_extract_scalar('_airbyte_data', ['total'], ['total']) }} as total,
    {{ json_extract_scalar('_airbyte_data', ['params'], ['params']) }} as params,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['results'], ['results']) }} as results,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['backup_params'], ['backup_params']) }} as backup_params,
    {{ json_extract_scalar('_airbyte_data', ['filterable_id'], ['filterable_id']) }} as filterable_id,
    {{ json_extract_scalar('_airbyte_data', ['filterable_type'], ['filterable_type']) }} as filterable_type,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
-- filters
where 1 = 1
