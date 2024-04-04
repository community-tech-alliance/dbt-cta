{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_steps" %}

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
    {{ json_extract_scalar('_airbyte_data', ['rules'], ['rules']) }} as rules,
    {{ json_extract_scalar('_airbyte_data', ['ladder_id'], ['ladder_id']) }} as ladder_id,
    {{ json_extract_scalar('_airbyte_data', ['step_type'], ['step_type']) }} as step_type,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['next_step_id'], ['next_step_id']) }} as next_step_id,
    {{ json_extract_scalar('_airbyte_data', ['alternate_next_step_id'], ['alternate_next_step_id']) }} as alternate_next_step_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
-- steps
where 1 = 1
