{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_owned_phone_number" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    {{ json_extract_scalar('_airbyte_data', ['service'], ['service']) }} as service,
    {{ json_extract_scalar('_airbyte_data', ['allocated_to_id'], ['allocated_to_id']) }} as allocated_to_id,
    {{ json_extract_scalar('_airbyte_data', ['area_code'], ['area_code']) }} as area_code,
    {{ json_extract_scalar('_airbyte_data', ['service_id'], ['service_id']) }} as service_id,
    {{ json_extract_scalar('_airbyte_data', ['allocated_to'], ['allocated_to']) }} as allocated_to,
    {{ json_extract_scalar('_airbyte_data', ['organization_id'], ['organization_id']) }} as organization_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['phone_number'], ['phone_number']) }} as phone_number,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['allocated_at'], ['allocated_at']) }} as allocated_at,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }} as table_alias
-- owned_phone_number
where 1 = 1


