{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_applicants" %}

{{ config(
    cluster_by = "airbyte_extracted_at",
    partition_by = {"field": "airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "airbyte_raw_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta_raw', '_airbyte_raw_applicants') }}
select
    {{ json_extract_scalar('_airbyte_data', ['apply_date'], ['apply_date']) }} as apply_date,
    {{ json_extract_scalar('_airbyte_data', ['job_id'], ['job_id']) }} as job_id,
    {{ json_extract_scalar('_airbyte_data', ['last_name'], ['last_name']) }} as last_name,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['job_title'], ['job_title']) }} as job_title,
    {{ json_extract_scalar('_airbyte_data', ['first_name'], ['first_name']) }} as first_name,
    {{ json_extract_scalar('_airbyte_data', ['prospect_phone'], ['prospect_phone']) }} as prospect_phone,
    airbyte_raw_id,
    airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', '_airbyte_raw_applicants') }} as table_alias
-- applicants
where 1 = 1

