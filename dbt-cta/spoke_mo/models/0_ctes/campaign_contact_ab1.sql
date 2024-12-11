{% set raw_table = env_var("CTA_DATASET_ID", "not-set") ~ "_raw__stream_campaign_contact" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', raw_table) }}
select
    {{ json_extract_scalar('_airbyte_data', ['zip'], ['zip']) }} as zip,
    {{ json_extract_scalar('_airbyte_data', ['custom_fields'], ['custom_fields']) }} as custom_fields,
    {{ json_extract_scalar('_airbyte_data', ['timezone_offset'], ['timezone_offset']) }} as timezone_offset,
    {{ json_extract_scalar('_airbyte_data', ['is_opted_out'], ['is_opted_out']) }} as is_opted_out,
    {{ json_extract_scalar('_airbyte_data', ['last_name'], ['last_name']) }} as last_name,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['external_id'], ['external_id']) }} as external_id,
    {{ json_extract_scalar('_airbyte_data', ['cell'], ['cell']) }} as cell,
    {{ json_extract_scalar('_airbyte_data', ['assignment_id'], ['assignment_id']) }} as assignment_id,
    {{ json_extract_scalar('_airbyte_data', ['message_status'], ['message_status']) }} as message_status,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['error_code'], ['error_code']) }} as error_code,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['first_name'], ['first_name']) }} as first_name,
    {{ json_extract_scalar('_airbyte_data', ['campaign_id'], ['campaign_id']) }} as campaign_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
-- campaign_contact
where 1 = 1
